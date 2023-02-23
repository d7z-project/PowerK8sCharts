REMOTE?=https://boot.powerk8s.cn/charts
AUTH?=admin:admin

charts:
	rm -rf build/charts && mkdir -p build/charts && \
	for chart in $$(ls Charts) ; do test -d "Charts/$$chart" && (cd build/charts && helm package ../../Charts/$$chart/ );  done

update: charts
	for chart in $$(ls build/charts/*.tgz ) ; do test -f "$$chart" && \
	NAME=$$(basename $$chart | sed -e 's|.tgz$$||g' -e 's/\(.*\)-/\1 /' -e 's| |/|g') ;\
	curl -k -X DELETE $(REMOTE)/api/charts/$$NAME  -u "$(AUTH)" ||:; \
 	curl -k $(REMOTE)/api/charts --data-binary "@$$chart" -u "$(AUTH)" ||:; done

images:
	IMAGES=(); \
 	for chart in $$(ls Charts) ;  \
 	do test -d "Charts/$$chart" && \
 	for image in $$(helm template $$chart Charts/$$chart | grep image: | awk '{print $$2}' | sed 's|"||g' | sort -u) ; do \
 	  if [[ ! " $${IMAGES[*]} " =~ " $$image " ]] ; then \
 	    IMAGES+=("$$image"); \
 	  fi; \
 	  done; \
 	done; \
 	for img in "$${IMAGES[@]}"; do \
 	  podman push --tls-verify=false $$img ;\
 	done
