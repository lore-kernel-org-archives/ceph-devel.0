From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Python-rados announcement
Date: Wed, 9 Feb 2011 11:32:57 -0800
Message-ID: <AANLkTimqmEa6TbXXxKmscXgJPmGGE69nmHf1bsiRXF_m@mail.gmail.com>
References: <4D4E9B93.2070901@ormod.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63775 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab1BITc6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Feb 2011 14:32:58 -0500
Received: by fxm20 with SMTP id 20so566407fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Feb 2011 11:32:57 -0800 (PST)
In-Reply-To: <4D4E9B93.2070901@ormod.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannu Valtonen <me@ormod.com>
Cc: ceph-devel@vger.kernel.org

Hi Hannu,

This looks like a good start. Since it's under LGPL 2.1 (same license
as Ceph), we'd like to merge it into Ceph so that the python bindings
can be used by all. What do you think?

cheers,
Colin


On Sun, Feb 6, 2011 at 5:01 AM, Hannu Valtonen <me@ormod.com> wrote:
> Hello,
>
> I wrote a basic Python ctypes librados wrapper:
> https://github.com/Ormod/python-rados
>
> It's in very initial stages of development and only supports things l=
ike
> write/read/deletes at this stage.
>
> Any patches/bugs/ideas are welcome and can be sent my way.
>
> - Hannu Valtonen
> hannu.valtonen@ormod.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
