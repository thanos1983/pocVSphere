from diagrams import Cluster, Diagram
from diagrams.aws.compute import ECS
from diagrams.aws.management import Cloudformation
from diagrams.aws.integration import ConsoleMobileApplication
from diagrams.azure.compute import VM
from diagrams.gcp.compute import GCE
from diagrams.programming.language import Bash
from diagrams.onprem import vcs
from diagrams.onprem import iac
from diagrams.oci import compute
from diagrams.onprem.compute import Server
from diagrams.generic.virtualization import Vmware
from diagrams.generic import os

with Diagram("Terrascan architecture", show=False):
    # cli = Bash("CLI")
    # server = Server("API server")
    # notifier = ConsoleMobileApplication("Notifier (Webhook)")
    # writer = Bash("Writer (JSON, YAML, XML)")

    # with Cluster("IaC Providers"):
    #     tf = iac.Terraform("Terraform")
    #     ansible = iac.Ansible("Ansible")
    #     cft = Cloudformation("CloudFormation")
    #     vmware = Vmware("VMWare API")

    # with Cluster("VMWare"):
    #     vm = compute.VirtualMachine("VM1")
    #     git = vcs.Git("Code Control")

    with Cluster("Operating System"):
        policy = [
            os.Windows("Windows OS"),
            os.LinuxGeneral("Linux OS")
        ]
        # with Cluster("Operating System"):
        #     win = os.Windows("Windows OS")
        #     linux = os.LinuxGeneral("Linux OS")

        # with Cluster("IaC Providers"):
        #     tf = iac.Terraform("Terraform")
        #     ansible = iac.Ansible("Ansible")
        #     cft = Cloudformation("CloudFormation")

        with Cluster("Policy Engine"):
            policy = [
                VM("Azure"),
                GCE("GCP"),
                ECS("AWS")
            ]

        # server >> output >> tf >> policy >> notifier
        # cli >> output >> ansible >> policy >> writer
        # output >> cft >> policy
