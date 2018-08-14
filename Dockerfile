################## BASE IMAGE ######################
FROM nfcore/base

################## METADATA ######################

LABEL base_image="nfcore/base"
LABEL version="1.0"
LABEL software="vt-nf"
LABEL software.version="1.0"
LABEL about.summary="vt normalization with nextflow"
LABEL about.home="http://github.com/IARCbioinfo/vt-nf"
LABEL about.documentation="http://github.com/IARCbioinfo/vt-nf/README.md"
LABEL about.license_file="http://github.com/IARCbioinfo/vt-nf/LICENSE.txt"
LABEL about.license="GNU-3.0"

################## MAINTAINER ######################
MAINTAINER Tiffany Delhomme <delhommet@students.iarc.fr>

################## INSTALLATION ######################

COPY environment.yml /
RUN conda env update -n root -f /environment.yml && conda clean -a
