From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] OSD systemd unit files makes it look failed
Date: Thu, 20 Nov 2014 06:56:43 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411200652250.2374@cobra.newdream.net>
References: <CADkWibfOvOEr7cFcKNFmKBi+0-GhtXGVZrj3RQFqryC68Stcfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34693 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbaKTO4o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Nov 2014 09:56:44 -0500
In-Reply-To: <CADkWibfOvOEr7cFcKNFmKBi+0-GhtXGVZrj3RQFqryC68Stcfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Alba <ascanio.alba7@gmail.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, onlyjob@debian.org, ceph-devel@vger.kernel.org, clint@debian.org

Hi Anthony,

There is a discussion going on ceph-maintainers about the systemd unit 
files.  Dmitry Smirnov has posted his version at

http://anonscm.debian.org/cgit/pkg-ceph/ceph.git/commit/?h=experimental&id=3c22e192d964789365e8dc21c168c5fd8985f7d8

though we've made some progress since then.

Moving this thread to ceph-devel.  I don't have time to work on this at 
the moment but would be very happy to hear feedback on Dmitry's latest 
(and review pull requests :).

Thanks!
sage


On Thu, 20 Nov 2014, Anthony Alba wrote:

> Hi the current OSD systemd unit files starts the OSD daemons correctly
> and ceph is HEALTH_OK. However there are some process tracking issues
> and systemd thinks the service has failed.
> 
> systemctl stop ceph-osd@0
> 
>  cannot stop the OSDs.
> 
> [Service]
> EnvironmentFile=-/etc/sysconfig/ceph
> Environment=CLUSTER=cephtest
> ExecStart=/usr/bin/ceph-osd -f --cluster ${CLUSTER} --id %i
> ExecStartPre=/usr/libexec/ceph/ceph-osd-prestart.sh --cluster ${CLUSTER} --id %i
> 
> 
> [root@ceph1 ~]# systemctl status cephosd@0
> ceph-osd@0.service - Ceph object storage daemon
>    Loaded: loaded (/etc/systemd/system/ceph-osd@.service; enabled)
>    Active: failed (Result: exit-code) since Thu 2014-11-20 17:36:40
> SGT; 10min ago
>   Process: 4251 ExecStart=/usr/bin/ceph-osd -f --cluster ${CLUSTER}
> --id %i (code=exited, status=1/FAILURE)
>   Process: 4196 ExecStartPre=/usr/libexec/ceph/ceph-osd-prestart.sh
> --cluster ${CLUSTER} --id %i (code=exited, status=0/SUCCESS)
>  Main PID: 4251 (code=exited, status=1/FAILURE)
> 
> Nov 20 17:36:40 ceph1.cephtest.com systemd[1]: Starting Ceph object
> storage daemon...
> Nov 20 17:36:40 ceph1.cephtest.com ceph-osd-prestart.sh[4196]:
> create-or-move updated item name 'osd.0' weight 0.19 at location {...h
> map
> Nov 20 17:36:40 ceph1.cephtest.com systemd[1]: Started Ceph object
> storage daemon.
> Nov 20 17:36:40 ceph1.cephtest.com ceph-osd[4251]: starting osd.0 at
> :/0 osd_data /var/lib/ceph/osd/cephtest-0
> /var/lib/ceph/osd/fl...ournal
> Nov 20 17:36:40 ceph1.cephtest.com ceph-osd[4251]: 2014-11-20
> 17:36:40.857110 7f422e034880 -1 asok(0x4740230)
> AdminSocketConfigO...exists
> Nov 20 17:36:40 ceph1.cephtest.com ceph-osd[4251]: 2014-11-20
> 17:36:40.857196 7f422e034880 -1
> filestore(/var/lib/ceph/osd/cephtest-...failed
> Nov 20 17:36:40 ceph1.cephtest.com ceph-osd[4251]: 2014-11-20
> 17:36:40.857207 7f422e034880 -1  ** ERROR: error converting store ...e
> busy
> Nov 20 17:36:40 ceph1.cephtest.com systemd[1]: ceph-osd@0.service:
> main process exited, code=exited, status=1/FAILURE
> Nov 20 17:36:40 ceph1.cephtest.com systemd[1]: Unit ceph-osd@0.service
> entered failed state.
> Nov 20 17:46:20 ceph1.cephtest.com systemd[1]: Stopped Ceph object
> storage daemon.
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
