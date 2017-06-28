From: Sage Weil <sage@newdream.net>
Subject: Re: osd full still writing data while cluster recovering
Date: Wed, 28 Jun 2017 16:37:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706281636190.3424@piezo.novalocal>
References: <CALCdKocMeqpY=3dx8BqE96-9Gvt7bYo4DJHEP4bbU9vmUsRSkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-376776471-1498667844=:3424"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58168 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdF1QhZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 12:37:25 -0400
In-Reply-To: <CALCdKocMeqpY=3dx8BqE96-9Gvt7bYo4DJHEP4bbU9vmUsRSkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: handong He <hedongho@gmail.com>, dzafman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-376776471-1498667844=:3424
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 28 Jun 2017, handong He wrote:
> Hello,
> 
> I'm using ceph-jewel 10.2.7 for some test.
> Discovered that when an osd is full(like full_ratio=0.95), client
> write failed, which is normal. But a full osd cannot stop a recovering
> cluster writing data, make osd used ratio from 95% to100%. When that
> happen, osd will be down for no space left and cannot startup anymore.
> 
> So the question is : can the cluster auto stop recovering while osd is
> reaching full without setting the norecover flag manually?  Or is it
> already fix in the latest version?
> 
> Consider this situation: a half-full cluster with many osds. For some
> bad luck(netlink down| server down | or others) in midnight, some osds
> down|out and trigger cluster recovery, makes some  other health osds'
> used% to 100% (experienceless in operation and maintenance, please fix
> me if i'm wrong). Unluckly, this just like a plague and make much more
> osds down. It maybe easy to fix one down osd like that, but a disaster
> to fix 10+ osds with 100% space used.

There are additional thresholds for stopping backfill and (later) a 
failsafe to prevent any writes, but you're not hte first one to see these 
not work properly in jewel.  David recently made a ton of 
improvements here in master for luminous, but I'm not sure what the 
status is for backporting some of the critical pieces to jewel...

sage

 
> here is my test environment and steps:
> 
> three nodes, each node has one monitor and one osd(10G hdd for
> convenient), running in vm.
> ceph conf is basic.
> pool size set to 2.
> using 'rados bench' writing data to osds.
> 
> 1. exec command  to set osd full ratio:
> # ceph pg set_full_ratio 0.8
> # ceph pg set nearfull_ratio 0.7
> 
> 2. writing data, when an osd is reaching full, stop writing and mark
> out one osd with command:
> # ceph osd out 0
> 
> 3. waiting for cluster recovering finished , and exec command:
> # ceph osd df
> # ceph osd tree
> 
> we can find that other osds is down.
> 
> Thanks and Best Regards！
> 
> He Handong
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-376776471-1498667844=:3424--
