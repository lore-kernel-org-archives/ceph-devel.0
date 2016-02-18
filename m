From: huang jun <hjwsm1989@gmail.com>
Subject: Re: Use xattr to replace omap operations in rbd
Date: Thu, 18 Feb 2016 09:01:29 +0800
Message-ID: <CABAwU-Z8OAvAD=Hjioj4TnMc4L8th9JvgQHGoP9OCJg6-+4ZCA@mail.gmail.com>
References: <CABAwU-Ysn9f=U+Aj53n_2k6L_5U_ViaOhXQ_UR9VPdbCisxhTQ@mail.gmail.com>
	<1834073137.24389531.1455726086385.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36664 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161084AbcBRBBa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Feb 2016 20:01:30 -0500
Received: by mail-lb0-f180.google.com with SMTP id x1so19554656lbj.3
        for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 17:01:30 -0800 (PST)
In-Reply-To: <1834073137.24389531.1455726086385.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

thansk, jason
for format 1, the tmap operations will call the OSD_SYNC_READ, which
is not supported by EC.
and for format 2, i think it's worth to try to replace omap with xattrs.
the main work is in class_api.cc, functions like cls_cxx_map_***
convert omap operations to xattr.

2016-02-18 0:21 GMT+08:00 Jason Dillaman <dillaman@redhat.com>:
> One of the biggest issues is that EC pools do not currently support overwrites.  There is design work underway to address this limitation [1].  As for replacing tmap/omap with xattrs, I heard through the grapevine that the goal is to also support omap directly within an EC pool (via replication).  tmap is used by format 1 RBD images and these images should be deprecated in favor of format 2, so I'm not sure it deserves much effort.  Additionally, all the current class methods used by RBD would need to be supported by the EC pool (rbd::get_id and rbd::object_map_XYZ methods issue a read/write ops).  Finally, any necessary changes would need to carefully consider backwards compatibility with older RBD images, clients, and OSDs.
>
> [1] http://tracker.ceph.com/projects/ceph/wiki/CDM_03-FEB-2016
>
> --
>
> Jason Dillaman
>
>
> ----- Original Message -----
>> From: "huang jun" <hjwsm1989@gmail.com>
>> To: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Sent: Wednesday, February 17, 2016 10:46:49 AM
>> Subject: Use xattr to replace omap operations in rbd
>>
>> hi,all
>> now, rbd can only use erasure code pool  with cache tier.
>> If we want to use rbd + ec, without cache tier,
>> that means all rbd operations should be rollback,
>> after trace the rbd code, there are many tmap\omap ops which not
>> supported by ec.
>> can i replace the omap operations to xattr, does it works?
>> and for rbd kernel module,what should be done to support rbd +ec?
>>
>> By the way, what's main difference between xattr and omap?
>> bc the omap performance is better when storing larger bytes?
>>
>> --
>> thanks
>> huangjun
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>



-- 
thanks
huangjun
