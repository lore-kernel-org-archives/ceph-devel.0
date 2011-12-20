From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Could rados pool support tree view feature ?
Date: Mon, 19 Dec 2011 22:38:39 -0800
Message-ID: <CAF3hT9Am_untCjpreygVd4TuUx6m=0+gb7BNXEMRD_tonPkFTg@mail.gmail.com>
References: <1324277505.4089.26.camel@cephclient0>
	<CAORUGqD5yJyzDNmVRa5jaj54hF-JJU1UCqyNw5OAAhE4hHK8pQ@mail.gmail.com>
	<1324345678.4089.35.camel@cephclient0>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61001 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab1LTGij convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 01:38:39 -0500
Received: by iaeh11 with SMTP id h11so9781208iae.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 22:38:39 -0800 (PST)
In-Reply-To: <1324345678.4089.35.camel@cephclient0>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

Unfortunately pools are completely flat namespaces, and there's no
hierarchical relationship between pools (well, really it's a feature,
not something unfortunate). So any tree structure would need to be a
completely external thing, which I guess you would probably do with
naming conventions and some wrapper scripts.
-Greg

On Mon, Dec 19, 2011 at 5:47 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> Hi ,Tommi
> Thank you very much.
>
> 00011 and 00012 are sub-pools ,we want to map our iaas devices topolo=
gy
> view meta data to these these sub-pools as a reference model.
>
> On Tue, 2011-12-20 at 01:16 +0800, Tommi Virtanen wrote:
>> On Sun, Dec 18, 2011 at 22:51, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
>> > Could rados pool support tree view feature ?for instance :
>> >
>> > $rados lspools -m 172.16.10.10
>> > data
>> > metadata
>> > rbd
>> > Product:00000001
>> > =A9=C0=A9=A4=A9=A4 00011
>> > =A9=A6   =A9=B8=A9=A4=A9=A4 00012
>> > |        =A9=B8=A9=A4=A9=A4 00013
>>
>> What type are the 00011 and 00012 entries? Are they pools or objects=
,
>> or what? RADOS pools are flat namespaces of objects, there's no tree
>> structure there.
>>
>> You should be able to write that easily, for example less than 100
>> lines of Python using the "rados" module gets you the listing of the
>> pools and the objects in them, and then you can use whatever your
>> custom logic is for creating that tree shape.
>>
>> The Ceph team pretty much starts with the assumption that your pools
>> are going to have at least millions of objects, so it's unlikely we'=
ll
>> write pretty visual navigation apps listing individual objects. The
>> output would just be too long to be useful.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
