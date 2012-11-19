From: Gregory Farnum <greg@inktank.com>
Subject: Re: Is the disk on MDS used for journal?
Date: Mon, 19 Nov 2012 14:15:49 -0800
Message-ID: <CAPYLRzisruY+isALzAjARzDpMaJW_2XrfFmu2d8=F8zK_ma3LQ@mail.gmail.com>
References: <CABFZihvQE17k8FVTo66tm7LjPAFsGeA-cq2dfavY9gw66H4J-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51298 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab2KSWPt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 17:15:49 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so3756047iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 14:15:49 -0800 (PST)
In-Reply-To: <CABFZihvQE17k8FVTo66tm7LjPAFsGeA-cq2dfavY9gw66H4J-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liu yaqi <liuyaqiyaqi@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Nov 18, 2012 at 7:14 PM, liu yaqi <liuyaqiyaqi@gmail.com> wrote=
:
> Is the disk on MDS used for journal? Does it has some other use?

The MDS doesn't make any use of local disk space =97 it stores
everything in RADOS. You need enough local disk to provide a
configuration file, keyring, and debug logging (if you want those
things).
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
