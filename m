From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: luminous filesystem is degraded
Date: Wed, 13 Sep 2017 15:16:25 -0700
Message-ID: <CAKRxpusMJPDWfs8nzk8GRYMaiuJTXYRuOGgC7CKaq6Fww4gxnw@mail.gmail.com>
References: <CAKRxpusdzy+k=v8nhvfW9Y_zciHYOZSo9U8HNvFovAAnH-eGzg@mail.gmail.com>
 <CALe9h7f48vWZ1g6WtonOKfy9DowGGnJbBK12prfA7YjrWXUkhw@mail.gmail.com>
 <CAKRxputc+qygj_H9uOf=gQR-YCaOH4nYMR0gQyNVU4hmjrCYaw@mail.gmail.com>
 <alpine.DEB.2.11.1709051330430.21105@piezo.novalocal> <CAKRxpuusVzh-8qtpjLFn_wg3CUeSUm23jshwFaKL-2r+=N5rpQ@mail.gmail.com>
 <alpine.DEB.2.11.1709121950510.24068@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:46864 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdIMWQ1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Sep 2017 18:16:27 -0400
Received: by mail-it0-f43.google.com with SMTP id 6so704231itl.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 15:16:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709121950510.24068@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I reverted the 1 unfound object(in the MDS). I think that eventually
cleared despite getting a message initially saying it wasn't found.

My filesystem is still degraded. The revert action seemed to have
damaged my mds.  also the Clearing the unfound didn't seem to unstuck
the Degraded data redundancy. There is no recovery going on.

I'm looking into clearing  the unclean, degraded, & undersized pg, but
I don't think that will restore the damaged mds, and degraded
filesystem.
help.

    health: HEALTH_ERR
            1 filesystem is degraded
            1 mds daemon damaged
            Degraded data redundancy: 22517/1463016 objects degraded
(1.539%), 1 pg unclean, 1 pg degraded, 1 pg undersized

  services:
    mon: 3 daemons, quorum osdmon33,osdmonmgr66,osdmon72
    mds: cephfs-0/1/1 up , 3 up:standby, 1 damaged
    osd: 6 osds: 6 up, 6 in


On Tue, Sep 12, 2017 at 12:51 PM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 12 Sep 2017, Two Spirit wrote:
>> I don't have any OSDs that are down, so the 1 unfound object I think
>> needs to be manually cleared. I ran across a webpage a while ago  that
>> talked about how to clear it, but if you have a reference, would save
>> me a little time.
>
> http://docs.ceph.com/docs/master/rados/troubleshooting/troubleshooting-pg/#failures-osd-unfound
>
> sage
>
>> I've included the outputs of the commands you asked. The ceph test
>> network contains 6 osds, 3 mons, 3 mds, 1rgw 1mgr. ubuntu 64 bit
>> 14.04/16.04 mix.
>>
>> file system is degraded. Are there procedures how to get this back in operation?
>>
>> On Tue, Sep 5, 2017 at 6:33 AM, Sage Weil <sweil@redhat.com> wrote:
>> > On Mon, 4 Sep 2017, Two Spirit wrote:
>> >> Thanks for the info. I'm stumped what to do right now to get back to
>> >> an operation cluster -- still trying to find documentation on how to
>> >> recover.
>> >>
>> >>
>> >> 1) I have not yet modified any CRUSH rules from the defaults. I have
>> >> one ubuntu 14.04 OSD in the mix, and I had to set "ceph osd crush
>> >> tunables legacy" just to get it to work.
>> >>
>> >> 2) I have not yet implemented any Erasure Code pool. That is probably
>> >> one of the next tests I was going to do.  I'm still testing with basic
>> >> replication.
>> >
>> > Can you attach 'ceph health detail', 'ceph osd crush dump', and 'ceph osd
>> > dump'?
>> >
>> >> The degraded data redundancy seems to be stuck and not reducing
>> >> anymore. If I manually clear [if this is even possible] the 1 pg
>> >> undersized, should my degraded filesystem go back online?
>> >
>> > The problem is likely the 1 unfound object.  Are there any OSDs that are
>> > down that failed recently?  (Try 'ceph osd tree down' to see a simple
>> > summary.)
>> >
>> > sage
>> >
>> >
>> >>
>> >> On Mon, Sep 4, 2017 at 2:05 AM, John Spray <jspray@redhat.com> wrote:
>> >> > On Sun, Sep 3, 2017 at 2:14 PM, Two Spirit <twospirit6905@gmail.com> wrote:
>> >> >> Setup: luminous on
>> >> >> Ubuntu 14.04/16.04 mix. 5 OSD. all up. 3 or 4 mds, 3mon,cephx
>> >> >> rebooting all 6 ceph systems did not clear the problem. Failure
>> >> >> occurred within 6 hours of start of test.
>> >> >> similar stress test with 4OSD,1MDS,1MON,cephx worked fine.
>> >> >>
>> >> >>
>> >> >> stress test
>> >> >> # cp * /mnt/cephfs
>> >> >>
>> >> >> # ceph -s
>> >> >>     health: HEALTH_WARN
>> >> >>             1 filesystem is degraded
>> >> >>             crush map has straw_calc_version=0
>> >> >>             1/731529 unfound (0.000%)
>> >> >>             Degraded data redundancy: 22519/1463058 objects degraded
>> >> >> (1.539%), 2 pgs unclean, 2 pgs degraded, 1 pg undersized
>> >> >>
>> >> >>   services:
>> >> >>     mon: 3 daemons, quorum xxx233,xxx266,xxx272
>> >> >>     mgr: xxx266(active)
>> >> >>     mds: cephfs-1/1/1 up  {0=xxx233=up:replay}, 3 up:standby
>> >> >>     osd: 5 osds: 5 up, 5 in
>> >> >>     rgw: 1 daemon active
>> >> >
>> >> > Your MDS is probably stuck in the replay state because it can't read
>> >> > from one of your degraded PGs.  Given that you have all your OSDs in,
>> >> > but one of your PGs is undersized (i.e. is short on OSDs), I would
>> >> > guess that something is wrong with your choice of CRUSH rules or EC
>> >> > config.
>> >> >
>> >> > John
>> >> >
>> >> >>
>> >> >> # ceph mds dump
>> >> >> dumped fsmap epoch 590
>> >> >> fs_name cephfs
>> >> >> epoch   589
>> >> >> flags   c
>> >> >> created 2017-08-24 14:35:33.735399
>> >> >> modified        2017-08-24 14:35:33.735400
>> >> >> tableserver     0
>> >> >> root    0
>> >> >> session_timeout 60
>> >> >> session_autoclose       300
>> >> >> max_file_size   1099511627776
>> >> >> last_failure    0
>> >> >> last_failure_osd_epoch  1573
>> >> >> compat  compat={},rocompat={},incompat={1=base v0.20,2=client
>> >> >> writeable ranges,3=default file layouts on dirs,4=dir inode in
>> >> >> separate object,5=mds uses versioned encoding,6=dirfrag is stored in
>> >> >> omap,8=file layout v2}
>> >> >> max_mds 1
>> >> >> in      0
>> >> >> up      {0=579217}
>> >> >> failed
>> >> >> damaged
>> >> >> stopped
>> >> >> data_pools      [5]
>> >> >> metadata_pool   6
>> >> >> inline_data     disabled
>> >> >> balancer
>> >> >> standby_count_wanted    1
>> >> >> 579217: x.x.x.233:6804/1176521332 'xxx233' mds.0.589 up:replay seq 2
>> >> >> --
>> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >>
>>
