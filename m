From: Ricardo Dias <rdias@suse.com>
Subject: Re: static member variable in libcommon and double free
Date: Tue, 26 Jul 2016 11:29:01 +0100
Message-ID: <20160726102901.GA24441@rdias-suse-laptop>
References: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:47135 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcGZK3f (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 26 Jul 2016 06:29:35 -0400
Content-Disposition: inline
In-Reply-To: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Here goes my 2 cents...

My vote is on to forbid the non-POD static variables in libcommon!

--
Ricardo Dias


On 2016-07-26 17:32:34, kefu chai wrote:
> 
> so, maybe we should just forbid the non-POD static variables in
> libcommon? if you have  better solution, or i am completely wrong (i
> wish so), please let me know.
> 
> thanks,
> 
> -- 
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
