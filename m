From: Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>
Subject: Re: Help with CEPH deployment
Date: Mon, 04 May 2015 10:32:07 +1200
Message-ID: <5546A1E7.7060208@catalyst.net.nz>
References: <CAKKTCLVJJA04BuymLiONYKmJELGpbPp776g=btF1ha4TRhHR-w@mail.gmail.com>
	<CAKKTCLXG3nzSQs8V5Qq7ycpbd__-vVHMG3Dma+Mihij4o7kakg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAKKTCLXG3nzSQs8V5Qq7ycpbd__-vVHMG3Dma+Mihij4o7kakg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Venkateswara Rao Jujjuri <jujjuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 04/05/15 05:42, Venkateswara Rao Jujjuri wrote:
> Here is the output..I am still stuck at this step. :(
> (multiple times tried to by purging and restarting from scratch)
>
> vjujjuri@rgulistan-wsl10:~/ceph-cluster$ ceph-deploy mon create-initial
> [ceph_deploy.conf][DEBUG ] found configuration file at:
> /home/vjujjuri/.cephdeploy.conf
> [ceph_deploy.cli][INFO  ] Invoked (1.5.23): /usr/bin/ceph-deploy mon
> create-initial
> [ceph_deploy.mon][DEBUG ] Deploying mon, cluster ceph hosts rgulistan-wsl11
> [ceph_deploy.mon][DEBUG ] detecting platform for host rgulistan-wsl11 ...
> [rgulistan-wsl11][DEBUG ] connection detected need for sudo
> [rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11
> [rgulistan-wsl11][DEBUG ] detect platform information from remote host
> [rgulistan-wsl11][DEBUG ] detect machine type
> [ceph_deploy.mon][INFO  ] distro info: Ubuntu 12.04 precise
> [rgulistan-wsl11][DEBUG ] determining if provided host has same
> hostname in remote
> [rgulistan-wsl11][DEBUG ] get remote short hostname
> [rgulistan-wsl11][DEBUG ] deploying mon to rgulistan-wsl11
> [rgulistan-wsl11][DEBUG ] get remote short hostname
> [rgulistan-wsl11][DEBUG ] remote hostname: rgulistan-wsl11
> [rgulistan-wsl11][DEBUG ] write cluster configuration to
> /etc/ceph/{cluster}.conf
> [rgulistan-wsl11][DEBUG ] create the mon path if it does not exist
> [rgulistan-wsl11][DEBUG ] checking for done path:
> /var/lib/ceph/mon/ceph-rgulistan-wsl11/done
> [rgulistan-wsl11][DEBUG ] create a done file to avoid re-doing the mon
> deployment
> [rgulistan-wsl11][DEBUG ] create the init path if it does not exist
> [rgulistan-wsl11][DEBUG ] locating the `service` executable...
> [rgulistan-wsl11][INFO  ] Running command: sudo initctl emit ceph-mon
> cluster=ceph id=rgulistan-wsl11
> [rgulistan-wsl11][INFO  ] Running command: sudo ceph --cluster=ceph
> --admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status
> [rgulistan-wsl11][DEBUG ]
> ********************************************************************************
> [rgulistan-wsl11][DEBUG ] status for monitor: mon.rgulistan-wsl11
> [rgulistan-wsl11][DEBUG ] {
> [rgulistan-wsl11][DEBUG ]   "election_epoch": 1,
> [rgulistan-wsl11][DEBUG ]   "extra_probe_peers": [],
> [rgulistan-wsl11][DEBUG ]   "monmap": {
> [rgulistan-wsl11][DEBUG ]     "created": "2015-05-02 10:52:17.318500",
> [rgulistan-wsl11][DEBUG ]     "epoch": 1,
> [rgulistan-wsl11][DEBUG ]     "fsid": "64e48bd5-f174-44a4-a485-7df3adbdad3d",
> [rgulistan-wsl11][DEBUG ]     "modified": "2015-05-02 10:52:17.318500",
> [rgulistan-wsl11][DEBUG ]     "mons": [
> [rgulistan-wsl11][DEBUG ]       {
> [rgulistan-wsl11][DEBUG ]         "addr": "xx.xx.xx.xx:6789/0",
> [rgulistan-wsl11][DEBUG ]         "name": "rgulistan-wsl11",
> [rgulistan-wsl11][DEBUG ]         "rank": 0
> [rgulistan-wsl11][DEBUG ]       }
> [rgulistan-wsl11][DEBUG ]     ]
> [rgulistan-wsl11][DEBUG ]   },
> [rgulistan-wsl11][DEBUG ]   "name": "rgulistan-wsl11",
> [rgulistan-wsl11][DEBUG ]   "outside_quorum": [],
> [rgulistan-wsl11][DEBUG ]   "quorum": [
> [rgulistan-wsl11][DEBUG ]     0
> [rgulistan-wsl11][DEBUG ]   ],
> [rgulistan-wsl11][DEBUG ]   "rank": 0,
> [rgulistan-wsl11][DEBUG ]   "state": "leader",
> [rgulistan-wsl11][DEBUG ]   "sync_provider": []
> [rgulistan-wsl11][DEBUG ] }
> [rgulistan-wsl11][DEBUG ]
> ********************************************************************************
> [rgulistan-wsl11][INFO  ] monitor: mon.rgulistan-wsl11 is running
> [rgulistan-wsl11][INFO  ] Running command: sudo ceph --cluster=ceph
> --admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status
> [ceph_deploy.mon][INFO  ] processing monitor mon.rgulistan-wsl11
> [rgulistan-wsl11][DEBUG ] connection detected need for sudo
> [rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11
> [rgulistan-wsl11][INFO  ] Running command: sudo ceph --cluster=ceph
> --admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status
> [ceph_deploy.mon][INFO  ] mon.rgulistan-wsl11 monitor has reached quorum!
> [ceph_deploy.mon][INFO  ] all initial monitors are running and have
> formed quorum
> [ceph_deploy.mon][INFO  ] Running gatherkeys...
> [ceph_deploy.gatherkeys][DEBUG ] Checking rgulistan-wsl11 for
> /etc/ceph/ceph.client.admin.keyring
> [rgulistan-wsl11][DEBUG ] connection detected need for sudo
> [rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11
> [rgulistan-wsl11][DEBUG ] detect platform information from remote host
> [rgulistan-wsl11][DEBUG ] detect machine type
> [rgulistan-wsl11][DEBUG ] fetch remote file
> [ceph_deploy.gatherkeys][WARNIN] Unable to find
> /etc/ceph/ceph.client.admin.keyring on rgulistan-wsl11
> [ceph_deploy][ERROR ] KeyNotFoundError: Could not find keyring file:
> /etc/ceph/ceph.client.admin.keyring on host rgulistan-wsl11
>
>


Hmmm, so this is Ubuntu 12.04, which should work ok.

It looks like the upstart command to start the monitor is working, which 
*should* kick off the key creation (see /etc/init/ceph-create-keys.conf).

I'd guess that ceph-create-keys is hanging or failing - do you see the 
process running, if not have a look in /var/log/ceph on the on host to 
see what is going on.

Regards

Mark
