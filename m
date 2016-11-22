From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: uint32_t BlueStore::Extent::logical_offset?
Date: Tue, 22 Nov 2016 21:53:18 +0000
Message-ID: <BY2PR02MB39660B0A6749CC3D6AF505EF4B40@BY2PR02MB396.namprd02.prod.outlook.com>
References: <8e0b5262-32ef-02a6-6812-a3e82369e9aa@mirantis.com>
 <alpine.DEB.2.11.1611222146240.11236@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0052.outbound.protection.outlook.com ([104.47.37.52]:21280
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933012AbcKVWJN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Nov 2016 17:09:13 -0500
In-Reply-To: <alpine.DEB.2.11.1611222146240.11236@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
OSD max obect size in the latest master is 100G , it used to be smaller..

OPTION(osd_max_object_size, OPT_U64, 100*1024L*1024L*1024L) // OSD's maximu=
m object size

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel=
.org] On Behalf Of Sage Weil
Sent: Tuesday, November 22, 2016 1:47 PM
To: Igor Fedotov
Cc: ceph-devel
Subject: Re: uint32_t BlueStore::Extent::logical_offset?

On Tue, 22 Nov 2016, Igor Fedotov wrote:
> Hi Sage,
>
>
> I'm wondering why BlueStore::Extent::logical_offset is 32-bit wide.
>
> IMHO it's to be uint64_t unless we limit onode size to 4Gb.
>
> Looks like we have implicit truncate when doing set_lextent/new Extent
> at the moment and hence some issues with large onodes are possible.

The max object size enforced in the OSD is ~128 MB (or in that neighborhood=
, if I remember correctly).  We really shouldn't be storing individual rado=
s objects that are orders of magnitude larger than that.

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in th=
e body of a message to majordomo@vger.kernel.org More majordomo info at  ht=
tp://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
