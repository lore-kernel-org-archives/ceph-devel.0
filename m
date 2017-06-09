From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] removing cluster name support
Date: Fri, 9 Jun 2017 16:42:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706091640530.3646@piezo.novalocal>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal> <5BCB72AC-A5E4-4CE3-BF6A-5164F4B64496@quantum.com> <alpine.DEB.2.11.1706081951440.23631@piezo.novalocal> <CAC-Np1wjRX99N4q69XfWY0m0fDETpRQZj5Hrgoe6kbrh7riE+A@mail.gmail.com>
 <CAMrEFZ62a7dToADh=-nbLy15Xx9=_mmJkmDjP-JY4mfarpd_5Q@mail.gmail.com> <CAKPXa=ZjsvhAMwdM9k47L4gaMGVispyJ7bMOyR7dVu0y7pb12A@mail.gmail.com> <CABZ+qq=UKuHYgv=QQHipMGAyKCpZj0wejZLEz=e+Bi+ZJ-sGzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbdFIQmp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Jun 2017 12:42:45 -0400
In-Reply-To: <CABZ+qq=UKuHYgv=QQHipMGAyKCpZj0wejZLEz=e+Bi+ZJ-sGzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Vasu Kulkarni <vakulkar@redhat.com>, wes_dillingham@harvard.edu, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Fri, 9 Jun 2017, Dan van der Ster wrote:
> On Fri, Jun 9, 2017 at 5:58 PM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
> > On Fri, Jun 9, 2017 at 6:11 AM, Wes Dillingham
> > <wes_dillingham@harvard.edu> wrote:
> >> Similar to Dan's situation we utilize the --cluster name concept for our
> >> operations. Primarily for "datamover" nodes which do incremental rbd
> >> import/export between distinct clusters. This is entirely coordinated by
> >> utilizing the --cluster option throughout.
> >>
> >> The way we set it up is that all clusters are actually named "ceph" on the
> >> mons and osds etc, but the clients themselves get /etc/ceph/clusterA.conf
> >> and /etc/ceph/clusterB.conf so that we can differentiate. I would like to
> >> see the functionality of clients being able to specify which conf file to
> >> read preserved.
> >
> > ceph.conf along with keyring file can stay in any location, the
> > default location is /etc/ceph but one could use
> > other location for clusterB.conf (
> > http://docs.ceph.com/docs/jewel/rados/configuration/ceph-conf/ ), At
> > least
> > for client which doesn't run any daemon this should be sufficient to
> > make it talk to different clusters.
> 
> So we start with this:
> 
> > ceph --cluster=flax health
> HEALTH_OK
> 
> Then for example do:
> > cd /etc/ceph/
> > mkdir flax
> > cp flax.conf flax/ceph.conf
> > cp flax.client.admin.keyring flax/ceph.client.admin.keyring
> 
> Now this works:
> 
> > ceph --conf=/etc/ceph/flax/ceph.conf --keyring=/etc/ceph/flax/ceph.client.admin.keyring health
> HEALTH_OK
> 
> So --cluster is just convenient shorthand for the CLI.

Yeah, although it's used elsewhere too:

$ grep \$cluster ../src/common/config_opts.h 
OPTION(admin_socket, OPT_STR, "$run_dir/$cluster-$name.asok") // default changed by common_preinit()
OPTION(log_file, OPT_STR, "/var/log/ceph/$cluster-$name.log") // default changed by common_preinit()
    "default=/var/log/ceph/$cluster.$channel.log cluster=/var/log/ceph/$cluster.log")
    "/etc/ceph/$cluster.$name.keyring,/etc/ceph/$cluster.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin," 
    "/usr/local/etc/ceph/$cluster.$name.keyring,/usr/local/etc/ceph/$cluster.keyring,"
OPTION(mon_data, OPT_STR, "/var/lib/ceph/mon/$cluster-$id")
OPTION(mon_debug_dump_location, OPT_STR, "/var/log/ceph/$cluster-$name.tdump")
OPTION(mds_data, OPT_STR, "/var/lib/ceph/mds/$cluster-$id")
OPTION(osd_data, OPT_STR, "/var/lib/ceph/osd/$cluster-$id")
OPTION(osd_journal, OPT_STR, "/var/lib/ceph/osd/$cluster-$id/journal")
OPTION(rgw_data, OPT_STR, "/var/lib/ceph/radosgw/$cluster-$id")
OPTION(mgr_data, OPT_STR, "/var/lib/ceph/mgr/$cluster-$id") // where to find keyring etc

The only non-daemon ones are admin_socket and log_file, so keep that in 
mind.

> I guess it won't be the end of the world if you drop it, but would it
> be so costly to keep that working? (CLI only -- no use-case for
> server-side named clusters over here).

But yeah... I don't think we'll change any of this except to make the 
deployment tools' lives easier by not support it there.

sage
