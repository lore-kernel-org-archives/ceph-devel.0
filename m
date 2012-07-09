From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Configuring radosgw to behave like Amazon S3
Date: Mon, 9 Jul 2012 09:39:17 -0700
Message-ID: <CAC-hyiGMrd4LVy6H5StT3SpXC6tx7ht3gooZT7mnh6bFBt05qA@mail.gmail.com>
References: <CAPUexz8vPRhfeNZEDz3dwqRmgvQdmAL2BY4Ddd=qUshE3S4xXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62487 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab2GIQjT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 12:39:19 -0400
Received: by bkwj10 with SMTP id j10so6198346bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 09:39:18 -0700 (PDT)
In-Reply-To: <CAPUexz8vPRhfeNZEDz3dwqRmgvQdmAL2BY4Ddd=qUshE3S4xXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 9, 2012 at 6:00 AM, Florian Haas <florian@hastexo.com> wrote:
> Hi,
>
> I find it kind of neat that you can use radosgw to convince S3 clients
> that they are in fact talking to the "real" Amazon S3, with just a bit
> of config and DNS trickery, but haven't seen this documented anywhere.
> So I decided to add a little page to the Hints & Kinks section on our
> website, in the hope that it's useful. If anyone wants to share
> comments, feedback or corrections, please do so either here on the
> list, or on the page directly (scroll down to "add new comment";
> leaving comments requires you to log in in an effort to combat comment
> spam).
>
> http://www.hastexo.com/resources/hints-and-kinks/configuring-radosgw-behave-amazon-s3

Note that for obvious reasons this method can't work when accessing
the RESTful api via https. It is useful as a workaround for handling
clients that are hard coded for amazon.

>
> As a side note, I'm not 100% sure if the information listed in
> http://ceph.com/docs/master/radosgw/s3/ with respect to S3 API
> compatibility is entirely accurate. Specifically, it seems that the
> "Bucket Website" feature *is* supported by way of "rgw dns name"
> (unless I'm missing something, and Bucket Website refers to something
> different). Thoughts on that would also be appreciated.

Yeah, you're missing something. Bucket website is a way to configure a
bucket to behave like a static website by providing default landing
page when accessing the bucket's root, and by providing default error
pages. You can read all about it here:

http://docs.amazonwebservices.com/AmazonS3/latest/dev/WebsiteHosting.html


Yehuda
