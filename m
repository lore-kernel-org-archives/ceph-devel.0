From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: Questions about ceph OSD
Date: Tue, 2 Nov 2010 19:39:36 -0700
Message-ID: <AANLkTin_45jzRLNjDogGpuRaX-u4ELtzomdQUeHkcRoq@mail.gmail.com>
References: <1288750698.2317.18.camel@osd1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56377 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab0KCCjj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Nov 2010 22:39:39 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 51F7EC06A
	for <ceph-devel@vger.kernel.org>; Tue,  2 Nov 2010 19:39:39 -0700 (PDT)
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id F247CC065
	for <ceph-devel@vger.kernel.org>; Tue,  2 Nov 2010 19:39:38 -0700 (PDT)
Received: by wyf28 with SMTP id 28so143101wyf.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Nov 2010 19:39:37 -0700 (PDT)
In-Reply-To: <1288750698.2317.18.camel@osd1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Wu <cpwu@tnsoft.com.cn>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregf@hq.newdream.net>, colinm@hq.newdream.net, henry_c_chang@tcloudcomputing.com, joshd@hq.newdream.net, samuelj@hq.newdream.net, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yonggang Liu <myidpt@gmail.com>

Hi,

  there are probably a few directions that you can go, but I'm not
sure which would be the easiest or whether it'd actually make sense.
Just to have an idea about what you're really looking for, why
wouldn't doing nfs mount over secret/ work? Is there a real need for
that metadata to go through the mds?

Yehuda

On Tue, Nov 2, 2010 at 7:18 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> hi,
>
> Any ideas or suggestions about this? or , To solve this issue,i need
> deeply look into what parts ceph codes ,OSD ,CRUSH ,.OSD cluster
> expansion .. etc ? Thanks.
>
>
> Jeff.Wu
>
>
> ---------- Forwarded message ----------
> From:=A0Jeff Wu <cpwu@tnsoft.com.cn>
> To:=A0"sage@newdream.net" <sage@newdream.net>, "ceph-devel@vger.kerne=
l.org" <ceph-devel@vger.kernel.org>
> Date:=A0Tue, 2 Nov 2010 14:49:58 +0800
> Subject:=A0Questions about ceph OSD
> Hi ,
>
> I have recently been working the preliminary research whether ceph
> can use at our cloud computing storage system in the future ,
> ceph is a very very excellent file system.But ,Now ,i hit a very
> important problem for us:
>
> Normally, as ceph described , all of the data are saved at OSDs with
> CRUSHMAP at ceph system.
>
> but my goal is to :
> 1. add a ext3 disk to ceph system ,but doesn't set it as a OSD;
> 2. save the normal data at the OSDs of a ceph system;
> 3. save the special data to a local ext3 disk at a ceph system,
> =A0 the ext3 disk is not set as a ceph OSD,but its infos are added to
> =A0MDS and =A0MON,when Write the special data at a ceph client ,these
> special data are not saved to ceph server OSDs ,but saved at the loca=
l
> ext3 disk.
>
> like this:
> At ceph client:
> $ mount.ceph 1.2.3.4:6789:/ /ceph
> $ cd /ceph
> $ ls
> cloud user secret
>
> when do writing,"cloud and user" folder data are saved to ceph OSDs ,
> but "secret" folder data are saved to a local ext3 disk .
>
> My question is:
> Q1- If i add a new OSD to the ceph system ,but i do a special CRUSH
> placement map . Could this ways solved this problem ?,If can ,How ?
>
> Q2 - If to implement this function as a patch myself, Could you give =
me
> any ideas ? or what parts of ceph codes(server/client) that i need lo=
ok
> into ?
>
> Thanks for all help and reply .
>
>
> Jeff.Wu
> Transoft.inc ,Sr.software engineer.
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
