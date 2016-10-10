From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Jewel + nfs-ganesha v2.4
Date: Mon, 10 Oct 2016 10:18:04 -0400 (EDT)
Message-ID: <1390476282.4169321.1476109084207.JavaMail.zimbra@redhat.com>
References: <20161006193745.roibu5nbaqcge475@birch.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:39529 "EHLO
        mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbcJJOSH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Oct 2016 10:18:07 -0400
In-Reply-To: <20161006193745.roibu5nbaqcge475@birch.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karol Mroz <kmroz@suse.de>
Cc: ceph-devel@vger.kernel.org

Hi Karol,

Yes, jewel backports are in progress.

Matt

----- Original Message -----
> From: "Karol Mroz" <kmroz@suse.de>
> To: ceph-devel@vger.kernel.org
> Sent: Thursday, October 6, 2016 3:37:45 PM
> Subject: Jewel + nfs-ganesha v2.4
> 
> Hi Folks,
> 
> Building nfs-ganesha v2.4 against Ceph 10.2.3 (effectively upstream/jewel),
> it
> would appear that the RGW FSAL does not build due to missing:
> 
> +#define LIBRGW_FILE_VER_MAJOR 1
> +#define LIBRGW_FILE_VER_MINOR 1
> +#define LIBRGW_FILE_VER_EXTRA 0
> 
> in /usr/include/rados/{librgw.h, rgw_file.h}.
> 
> These were added via:
> 
> commit 355ccc5ded7f0b459bca24bc8b504b41807c583d
>     librgw: add API version defines for librgw and rgw_file
> 
> Any plans to backport this to the jewel release branch?
> 
> --
> Regards,
> Karol
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
