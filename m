From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-maintainers] [ceph-users] v12.1.4 Luminous (RC) released
Date: Fri, 25 Aug 2017 22:40:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708252240280.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-413119540-1503700840=:20435"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932871AbdHYWkl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 25 Aug 2017 18:40:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: David Zafman <dzafman@redhat.com>, Vasu Kulkarni <vakulkar@redhat.com>, Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-413119540-1503700840=:20435
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 25 Aug 2017, Kamble, Nitin A wrote:
> Hi Sage,
> 
> I am planning to test in a normal setup. Do I need to set debug level 20 
> for bluestore to see these messages?

You should see it at normal debug levels.

Thanks!
sage


> 
> Nitin
> 
> On 8/25/17, 3:17 PM, "ceph-devel-owner@vger.kernel.org on behalf of Kamble, Nitin A" <ceph-devel-owner@vger.kernel.org on behalf of Nitin.Kamble@Teradata.com> wrote:
> 
>     
>     
>     On 8/25/17, 3:11 PM, "Sage Weil" <sweil@redhat.com> wrote:
>     Okay, I have a patch that repairs this.  See wip-21089-luminous, which 
>         should appear at
>         
>         	https://shaman.ceph.com/builds/ceph/wip-21089-luminous/
>         
>         in the next hour or so.  If you run fsck with this build you see a line 
>         like
>         
>         2017-08-25 18:01:58.656446 7f9e23825480 -1 bluestore(/home/sage/src/ceph4/build/dev/osd0) fsck warning: fixing leaked block 0x280000000~1000 due to old bug
>         2017-08-25 18:01:58.656451 7f9e23825480 -1 bluestore(/home/sage/src/ceph4/build/dev/osd0) fsck  freelist block and key count changed, fixing 0x280001000~7f000
>         
>         go by in the log on the next fsck, and no such message thereafter.  Can 
>         you give it a try on one of those OSDs to confirm it works?  I tested both 
>         cases I see locally but want to ensure it works in your case too.
>         
>         Thanks!
>         sage
>         
>         
>     Ok, will report my findings with this code.
>     
>     Thanks,
>     Nitin
>         
>     
>     ????{.n???+?????????????????????+%??????lzwm??????b???맲??????r??????yǩ???ׯzX?????????????ܨ}?????????Ơz???&j:+v??????????????????????zZ+??????+zf?????????h?????????~????????????i?????????z???????w??????????????????????&???)ߢ?f
> 
> 
--8323329-413119540-1503700840=:20435--
