From: Venkateswara Rao Jujjuri <jujjuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Help with CEPH deployment
Date: Mon, 4 May 2015 09:16:23 -0700
Message-ID: <CAKKTCLWxPOan=Z46Kvx9t6pHpvz=eAGHzTOO0EtXO80scM_E3g@mail.gmail.com>
References: <CAKKTCLVJJA04BuymLiONYKmJELGpbPp776g=btF1ha4TRhHR-w@mail.gmail.com>
	<CAKKTCLXG3nzSQs8V5Qq7ycpbd__-vVHMG3Dma+Mihij4o7kakg@mail.gmail.com>
	<5546A1E7.7060208@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1720648682=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5546A1E7.7060208-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1720648682==
Content-Type: multipart/alternative; boundary=001a113d582a186cb0051543e2b6

--001a113d582a186cb0051543e2b6
Content-Type: text/plain; charset=UTF-8

Thanks Mark. I switched to completely different machine and started from
scratch, things were much smoother this time. Cluster was up in 30 mins.
I guess purgedata , droplets and and purge is
Not enough to bring the machine back clean?
What I was trying on the old machine to reset it.

Thanks
JV

On Sunday, May 3, 2015, Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org> wrote:

> On 04/05/15 05:42, Venkateswara Rao Jujjuri wrote:
>
>> Here is the output..I am still stuck at this step. :(
>> (multiple times tried to by purging and restarting from scratch)
>>
>> vjujjuri@rgulistan-wsl10:~/ceph-cluster$ ceph-deploy mon create-initial
>> [ceph_deploy.conf][DEBUG ] found configuration file at:
>> /home/vjujjuri/.cephdeploy.conf
>> [ceph_deploy.cli][INFO  ] Invoked (1.5.23): /usr/bin/ceph-deploy mon
>> create-initial
>> [ceph_deploy.mon][DEBUG ] Deploying mon, cluster ceph hosts
>> rgulistan-wsl11
>> [ceph_deploy.mon][DEBUG ] detecting platform for host rgulistan-wsl11 ...
>> [rgulistan-wsl11][DEBUG ] connection detected need for sudo
>> [rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11
>> [rgulistan-wsl11][DEBUG ] detect platform information from remote host
>> [rgulistan-wsl11][DEBUG ] detect machine type
>> [ceph_deploy.mon][INFO  ] distro info: Ubuntu 12.04 precise
>> [rgulistan-wsl11][DEBUG ] determining if provided host has same
>> hostname in remote
>> [rgulistan-wsl11][DEBUG ] get remote short hostname
>> [rgulistan-wsl11][DEBUG ] deploying mon to rgulistan-wsl11
>> [rgulistan-wsl11][DEBUG ] get remote short hostname
>> [rgulistan-wsl11][DEBUG ] remote hostname: rgulistan-wsl11
>> [rgulistan-wsl11][DEBUG ] write cluster configuration to
>> /etc/ceph/{cluster}.conf
>> [rgulistan-wsl11][DEBUG ] create the mon path if it does not exist
>> [rgulistan-wsl11][DEBUG ] checking for done path:
>> /var/lib/ceph/mon/ceph-rgulistan-wsl11/done
>> [rgulistan-wsl11][DEBUG ] create a done file to avoid re-doing the mon
>> deployment
>> [rgulistan-wsl11][DEBUG ] create the init path if it does not exist
>> [rgulistan-wsl11][DEBUG ] locating the `service` executable...
>> [rgulistan-wsl11][INFO  ] Running command: sudo initctl emit ceph-mon
>> cluster=ceph id=rgulistan-wsl11
>> [rgulistan-wsl11][INFO  ] Running command: sudo ceph --cluster=ceph
>> --admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status
>> [rgulistan-wsl11][DEBUG ]
>>
>> ********************************************************************************
>> [rgulistan-wsl11][DEBUG ] status for monitor: mon.rgulistan-wsl11
>> [rgulistan-wsl11][DEBUG ] {
>> [rgulistan-wsl11][DEBUG ]   "election_epoch": 1,
>> [rgulistan-wsl11][DEBUG ]   "extra_probe_peers": [],
>> [rgulistan-wsl11][DEBUG ]   "monmap": {
>> [rgulistan-wsl11][DEBUG ]     "created": "2015-05-02 10:52:17.318500",
>> [rgulistan-wsl11][DEBUG ]     "epoch": 1,
>> [rgulistan-wsl11][DEBUG ]     "fsid":
>> "64e48bd5-f174-44a4-a485-7df3adbdad3d",
>> [rgulistan-wsl11][DEBUG ]     "modified": "2015-05-02 10:52:17.318500",
>> [rgulistan-wsl11][DEBUG ]     "mons": [
>> [rgulistan-wsl11][DEBUG ]       {
>> [rgulistan-wsl11][DEBUG ]         "addr": "xx.xx.xx.xx:6789/0",
>> [rgulistan-wsl11][DEBUG ]         "name": "rgulistan-wsl11",
>> [rgulistan-wsl11][DEBUG ]         "rank": 0
>> [rgulistan-wsl11][DEBUG ]       }
>> [rgulistan-wsl11][DEBUG ]     ]
>> [rgulistan-wsl11][DEBUG ]   },
>> [rgulistan-wsl11][DEBUG ]   "name": "rgulistan-wsl11",
>> [rgulistan-wsl11][DEBUG ]   "outside_quorum": [],
>> [rgulistan-wsl11][DEBUG ]   "quorum": [
>> [rgulistan-wsl11][DEBUG ]     0
>> [rgulistan-wsl11][DEBUG ]   ],
>> [rgulistan-wsl11][DEBUG ]   "rank": 0,
>> [rgulistan-wsl11][DEBUG ]   "state": "leader",
>> [rgulistan-wsl11][DEBUG ]   "sync_provider": []
>> [rgulistan-wsl11][DEBUG ] }
>> [rgulistan-wsl11][DEBUG ]
>>
>> ********************************************************************************
>> [rgulistan-wsl11][INFO  ] monitor: mon.rgulistan-wsl11 is running
>> [rgulistan-wsl11][INFO  ] Running command: sudo ceph --cluster=ceph
>> --admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status
>> [ceph_deploy.mon][INFO  ] processing monitor mon.rgulistan-wsl11
>> [rgulistan-wsl11][DEBUG ] connection detected need for sudo
>> [rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11
>> [rgulistan-wsl11][INFO  ] Running command: sudo ceph --cluster=ceph
>> --admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status
>> [ceph_deploy.mon][INFO  ] mon.rgulistan-wsl11 monitor has reached quorum!
>> [ceph_deploy.mon][INFO  ] all initial monitors are running and have
>> formed quorum
>> [ceph_deploy.mon][INFO  ] Running gatherkeys...
>> [ceph_deploy.gatherkeys][DEBUG ] Checking rgulistan-wsl11 for
>> /etc/ceph/ceph.client.admin.keyring
>> [rgulistan-wsl11][DEBUG ] connection detected need for sudo
>> [rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11
>> [rgulistan-wsl11][DEBUG ] detect platform information from remote host
>> [rgulistan-wsl11][DEBUG ] detect machine type
>> [rgulistan-wsl11][DEBUG ] fetch remote file
>> [ceph_deploy.gatherkeys][WARNIN] Unable to find
>> /etc/ceph/ceph.client.admin.keyring on rgulistan-wsl11
>> [ceph_deploy][ERROR ] KeyNotFoundError: Could not find keyring file:
>> /etc/ceph/ceph.client.admin.keyring on host rgulistan-wsl11
>>
>>
>>
>
> Hmmm, so this is Ubuntu 12.04, which should work ok.
>
> It looks like the upstart command to start the monitor is working, which
> *should* kick off the key creation (see /etc/init/ceph-create-keys.conf).
>
> I'd guess that ceph-create-keys is hanging or failing - do you see the
> process running, if not have a look in /var/log/ceph on the on host to see
> what is going on.
>
> Regards
>
> Mark
>
>

-- 
Sent from iPhone

--001a113d582a186cb0051543e2b6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks Mark. I switched to completely different machine and started from sc=
ratch, things were much smoother this time. Cluster was up in 30 mins.=C2=
=A0<br>I guess purgedata , droplets and=C2=A0and purge is<div>Not enough to=
 bring the machine back clean?<span></span></div><div>What I was trying on =
the old machine to reset it.=C2=A0</div><div><br></div><div>Thanks</div><di=
v>JV=C2=A0</div><div><br>On Sunday, May 3, 2015, Mark Kirkwood &lt;<a href=
=3D"mailto:mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org">mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org</a>=
&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">On 04/05/15 05:42, Venkateswa=
ra Rao Jujjuri wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Here is the output..I am still stuck at this step. :(<br>
(multiple times tried to by purging and restarting from scratch)<br>
<br>
vjujjuri@rgulistan-wsl10:~/ceph-cluster$ ceph-deploy mon create-initial<br>
[ceph_deploy.conf][DEBUG ] found configuration file at:<br>
/home/vjujjuri/.cephdeploy.conf<br>
[ceph_deploy.cli][INFO=C2=A0 ] Invoked (1.5.23): /usr/bin/ceph-deploy mon<b=
r>
create-initial<br>
[ceph_deploy.mon][DEBUG ] Deploying mon, cluster ceph hosts rgulistan-wsl11=
<br>
[ceph_deploy.mon][DEBUG ] detecting platform for host rgulistan-wsl11 ...<b=
r>
[rgulistan-wsl11][DEBUG ] connection detected need for sudo<br>
[rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11<br>
[rgulistan-wsl11][DEBUG ] detect platform information from remote host<br>
[rgulistan-wsl11][DEBUG ] detect machine type<br>
[ceph_deploy.mon][INFO=C2=A0 ] distro info: Ubuntu 12.04 precise<br>
[rgulistan-wsl11][DEBUG ] determining if provided host has same<br>
hostname in remote<br>
[rgulistan-wsl11][DEBUG ] get remote short hostname<br>
[rgulistan-wsl11][DEBUG ] deploying mon to rgulistan-wsl11<br>
[rgulistan-wsl11][DEBUG ] get remote short hostname<br>
[rgulistan-wsl11][DEBUG ] remote hostname: rgulistan-wsl11<br>
[rgulistan-wsl11][DEBUG ] write cluster configuration to<br>
/etc/ceph/{cluster}.conf<br>
[rgulistan-wsl11][DEBUG ] create the mon path if it does not exist<br>
[rgulistan-wsl11][DEBUG ] checking for done path:<br>
/var/lib/ceph/mon/ceph-rgulistan-wsl11/done<br>
[rgulistan-wsl11][DEBUG ] create a done file to avoid re-doing the mon<br>
deployment<br>
[rgulistan-wsl11][DEBUG ] create the init path if it does not exist<br>
[rgulistan-wsl11][DEBUG ] locating the `service` executable...<br>
[rgulistan-wsl11][INFO=C2=A0 ] Running command: sudo initctl emit ceph-mon<=
br>
cluster=3Dceph id=3Drgulistan-wsl11<br>
[rgulistan-wsl11][INFO=C2=A0 ] Running command: sudo ceph --cluster=3Dceph<=
br>
--admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status<br>
[rgulistan-wsl11][DEBUG ]<br>
***************************************************************************=
*****<br>
[rgulistan-wsl11][DEBUG ] status for monitor: mon.rgulistan-wsl11<br>
[rgulistan-wsl11][DEBUG ] {<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0&quot;election_epoch&quot;: 1,<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0&quot;extra_probe_peers&quot;: [],<br=
>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0&quot;monmap&quot;: {<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0&quot;created&quot;: &quot;201=
5-05-02 10:52:17.318500&quot;,<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0&quot;epoch&quot;: 1,<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0&quot;fsid&quot;: &quot;64e48b=
d5-f174-44a4-a485-7df3adbdad3d&quot;,<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0&quot;modified&quot;: &quot;20=
15-05-02 10:52:17.318500&quot;,<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0&quot;mons&quot;: [<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;addr&quot;=
: &quot;xx.xx.xx.xx:6789/0&quot;,<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;name&quot;=
: &quot;rgulistan-wsl11&quot;,<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;rank&quot;=
: 0<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A0]<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0},<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0&quot;name&quot;: &quot;rgulistan-wsl=
11&quot;,<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0&quot;outside_quorum&quot;: [],<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0&quot;quorum&quot;: [<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0 =C2=A00<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0],<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0&quot;rank&quot;: 0,<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0&quot;state&quot;: &quot;leader&quot;=
,<br>
[rgulistan-wsl11][DEBUG ]=C2=A0 =C2=A0&quot;sync_provider&quot;: []<br>
[rgulistan-wsl11][DEBUG ] }<br>
[rgulistan-wsl11][DEBUG ]<br>
***************************************************************************=
*****<br>
[rgulistan-wsl11][INFO=C2=A0 ] monitor: mon.rgulistan-wsl11 is running<br>
[rgulistan-wsl11][INFO=C2=A0 ] Running command: sudo ceph --cluster=3Dceph<=
br>
--admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status<br>
[ceph_deploy.mon][INFO=C2=A0 ] processing monitor mon.rgulistan-wsl11<br>
[rgulistan-wsl11][DEBUG ] connection detected need for sudo<br>
[rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11<br>
[rgulistan-wsl11][INFO=C2=A0 ] Running command: sudo ceph --cluster=3Dceph<=
br>
--admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status<br>
[ceph_deploy.mon][INFO=C2=A0 ] mon.rgulistan-wsl11 monitor has reached quor=
um!<br>
[ceph_deploy.mon][INFO=C2=A0 ] all initial monitors are running and have<br=
>
formed quorum<br>
[ceph_deploy.mon][INFO=C2=A0 ] Running gatherkeys...<br>
[ceph_deploy.gatherkeys][DEBUG ] Checking rgulistan-wsl11 for<br>
/etc/ceph/ceph.client.admin.keyring<br>
[rgulistan-wsl11][DEBUG ] connection detected need for sudo<br>
[rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11<br>
[rgulistan-wsl11][DEBUG ] detect platform information from remote host<br>
[rgulistan-wsl11][DEBUG ] detect machine type<br>
[rgulistan-wsl11][DEBUG ] fetch remote file<br>
[ceph_deploy.gatherkeys][WARNIN] Unable to find<br>
/etc/ceph/ceph.client.admin.keyring on rgulistan-wsl11<br>
[ceph_deploy][ERROR ] KeyNotFoundError: Could not find keyring file:<br>
/etc/ceph/ceph.client.admin.keyring on host rgulistan-wsl11<br>
<br>
<br>
</blockquote>
<br>
<br>
Hmmm, so this is Ubuntu 12.04, which should work ok.<br>
<br>
It looks like the upstart command to start the monitor is working, which *s=
hould* kick off the key creation (see /etc/init/ceph-create-keys.conf).<br>
<br>
I&#39;d guess that ceph-create-keys is hanging or failing - do you see the =
process running, if not have a look in /var/log/ceph on the on host to see =
what is going on.<br>
<br>
Regards<br>
<br>
Mark<br>
<br>
</blockquote></div><br><br>-- <br>Sent from iPhone<br>

--001a113d582a186cb0051543e2b6--

--===============1720648682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1720648682==--
