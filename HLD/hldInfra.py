from diagrams.azure import devops
from diagrams import Cluster, Diagram, Edge
from diagrams.oci.compute import VirtualMachine
from diagrams.generic import virtualization, os
from diagrams.aws.storage import SimpleStorageServiceS3
from diagrams.onprem import iac, vcs, security, container, compute

with Diagram("High Level Design - Provisioning Infrastructure", show=False, filename="hldInfra"):
    adoServer = devops.Devops("ADO Server")
    adoPipeline = devops.Pipelines("ADO Pipeline(s)")

    with Cluster("Version Control System"):
        [vcs.Git("Git"),
         devops.Repos("Azure DevOps VCS")] >> adoServer

    with Cluster("Infrastructure As Code Project"):
        with Cluster("Infrastructure As Code"):
            # tf = iac.Terraform("Terraform")
            ansible = iac.Ansible("Ansible")
            # vmware = virtualization.Vmware("VMWare API")

            with Cluster("Containerization Services"):
                docker = container.Docker("Container Engine")
                s3Bucket = SimpleStorageServiceS3("S3 Bucket with PV")
                vault = security.Vault("Hashicorp Vault with PV")

                docker \
                - Edge(color="firebrick", style="dashed") \
                >> s3Bucket \
                - Edge(color="firebrick", style="dashed") \
                << s3Bucket

                docker \
                - Edge(color="firebrick", style="dashed") \
                >> vault \
                - Edge(color="firebrick", style="dashed") \
                << vault

        # vault \
        # - Edge(color="black", style="dashed", label="get secrets") \
        # >> ansible \
        # - Edge(color="black", style="dashed", label="get secrets") \
        # << ansible
        #
        # s3Bucket \
        # - Edge(color="black", style="dashed", label="store state file") \
        # << ansible

        # with Cluster("Operating System"):
        #     operatingSystem = [
        #         os.Windows("Windows OS"),
        #         os.LinuxGeneral("Linux OS")
        #     ]
        #
        # with Cluster("VMWare VMs Cluster"):
        #     vm1 = VirtualMachine("VM 1st")
        #     vm2 = VirtualMachine("VM 2nd")
        #     vmn = VirtualMachine("VM nth")

            # vm1 \
            # - Edge(color="black", style="dashed") \
            # >> vm2 \
            # - Edge(color="black", style="dashed") \
            # << vm2

            # vm2 \
            # - Edge(color="black", style="dashed") \
            # >> vmn \
            # - Edge(color="black", style="dashed") \
            # << vmn

        # ansible >> vmware >> operatingSystem
        # operatingSystem >> vm1
        # operatingSystem >> vm2
        # operatingSystem >> vmn

    adoServer \
    - Edge(color="firebrick", style="dashed") \
    >> adoPipeline

    adoPipeline >> ansible >> docker
