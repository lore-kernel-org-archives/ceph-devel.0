From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: Can we have mutiple OSD in a single machine
Date: Wed, 11 Apr 2012 15:53:36 +0200
Message-ID: <CAMvP8PD5qkfV=xYPewuPM9W2o06vqNOU_DVBdXmzyNbaB-7RpA@mail.gmail.com>
References: <loom.20120411T093935-734@post.gmane.org> <6626464112406899193@unknownmsgid>
 <loom.20120411T143658-450@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64646 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760176Ab2DKNx5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 09:53:57 -0400
Received: by yenl12 with SMTP id l12so425665yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 06:53:56 -0700 (PDT)
In-Reply-To: <loom.20120411T143658-450@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

It'll not increase overall storage system performance. Partitioning of
single disk drive gives you no performance gains.





On Wed, Apr 11, 2012 at 2:38 PM, Madhusudhana U
<madhusudhana.u.acharya@gmail.com> wrote:
> Tomasz Paszkowski <ss7pro <at> gmail.com> writes:
>
>>
>> Hi,
>>
>> Please correct me if I'am wrong. You would like to partition single =
drive ?
>>
> Yes,
> I want to create 4 partitions in a =A0single drive. This will increas=
e the
> OSD number. Will this increase in OSD also increases performance ?
>
> Thanks
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
