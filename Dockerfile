FROM hashicorp/terraform:0.12.28

# Install dependencies.
RUN apk add --no-cache \
  bash \
  curl \
  openssl \
  python2

# Install Google Cloud SDK (latest version).
RUN curl -sSL https://sdk.cloud.google.com | bash -s -- --disable-prompts
RUN ~/google-cloud-sdk/bin/gcloud components update
ENV PATH "~/google-cloud-sdk/bin:$PATH"

# Install AWS CLI (latest version). Latest version information can be found at https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
RUN curl -o /tmp/awscli-bundle.zip -SSL https://s3.amazonaws.com/aws-cli/awscli-bundle.zip && \
  unzip /tmp/awscli-bundle.zip -d /tmp && \
  /tmp/awscli-bundle/install -i /usr/aws -b /bin/aws

# Install AWS IAM authenticator. Latest stable version can be found at https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
RUN curl -o /bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator && \
  chmod +x /bin/aws-iam-authenticator && \
  cp /bin/aws-iam-authenticator /bin/aws-iam-authenticator.exe

# Install kubectl (1.18.5). Latest stable version can be found at https://storage.googleapis.com/kubernetes-release/release/stable.txt
RUN curl -o /bin/kubectl -sSL https://storage.googleapis.com/kubernetes-release/release/v1.18.5/bin/linux/amd64/kubectl && \
  chmod +x /bin/kubectl

# Install Helm (3.2.4). Version histroy can be found at https://github.com/helm/helm/tags
ENV DESIRED_VERSION=v3.2.4
RUN curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash
RUN helm repo add stable https://kubernetes-charts.storage.googleapis.com/

ENTRYPOINT []
