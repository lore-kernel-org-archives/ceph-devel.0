From: Wido den Hollander <wido@42on.com>
Subject: Re: does librbd actually need leveldb?
Date: Sat, 16 Nov 2013 09:42:12 +0100
Message-ID: <52872FE4.5050003@42on.com>
References: <6035A0D088A63A46850C3988ED045A4B665EE988@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:54506 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449Ab3KPImP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 16 Nov 2013 03:42:15 -0500
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B665EE988@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/16/2013 09:37 AM, James Harper wrote:
> Does librbd actually need leveldb?
>

As far as I know, not. librbd is simply build on top of librados which 
doesn't need leveldb as well.

The monitors and OSDs use leveldb to store key/value pairs, but as far 
as I know none of the libraries require leveldb.

> And if so, does it need it in all cases?
>
> I'm trying to figure out what dependencies are required for librbd for win32, and leveldb doesn't build cleanly at first go.
>
> Thanks
>
> James
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
