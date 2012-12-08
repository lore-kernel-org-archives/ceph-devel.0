From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Behavior of librbd::Image::read_iterate() changed?
Date: Fri, 07 Dec 2012 21:04:56 -0800
Message-ID: <50C2CA78.5010005@inktank.com>
References: <CANExM-MYm5iomxv1GszEOo4+PJouGCzC+ssjm0FHhX1GuD-FXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60078 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab2LHFFA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Dec 2012 00:05:00 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so797060pbc.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Dec 2012 21:04:59 -0800 (PST)
In-Reply-To: <CANExM-MYm5iomxv1GszEOo4+PJouGCzC+ssjm0FHhX1GuD-FXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I suspect, but have not figured out yet, that this is due to the new 
striping code (even on images that don't have advanced striping 
enabled).  I know we want to look at it further; it might be that this 
is a regression.

On 12/07/2012 07:44 PM, Henry C Chang wrote:
> Hi,
>
> I am testing v0.55. I noticed that the behavior of
> librbd::Image::read_iterate() changed. With 0.48.2, when hitting the
> hole, the callback function will be called with the buf set to NULL.
> However, with v0.55, I got the zero-ed buffer of full length of the
> object (e.g., 4MB).
>
> Is it the expected behavior or a bug?
>
> Henry
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
