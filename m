From: Florian Haas <florian@hastexo.com>
Subject: Re: Configuring radosgw to behave like Amazon S3
Date: Mon, 09 Jul 2012 21:50:15 +0200
Message-ID: <4FFB35F7.5080807@hastexo.com>
References: <CAPUexz8vPRhfeNZEDz3dwqRmgvQdmAL2BY4Ddd=qUshE3S4xXw@mail.gmail.com> <CAC-hyiGMrd4LVy6H5StT3SpXC6tx7ht3gooZT7mnh6bFBt05qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37629 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab2GITuT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 15:50:19 -0400
Received: by weyx8 with SMTP id x8so1502188wey.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 12:50:18 -0700 (PDT)
In-Reply-To: <CAC-hyiGMrd4LVy6H5StT3SpXC6tx7ht3gooZT7mnh6bFBt05qA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/09/12 18:39, Yehuda Sadeh wrote:
> On Mon, Jul 9, 2012 at 6:00 AM, Florian Haas <florian@hastexo.com> wrote:
>> Hi,
>>
>> I find it kind of neat that you can use radosgw to convince S3 clients
>> that they are in fact talking to the "real" Amazon S3, with just a bit
>> of config and DNS trickery, but haven't seen this documented anywhere.
>> So I decided to add a little page to the Hints & Kinks section on our
>> website, in the hope that it's useful. If anyone wants to share
>> comments, feedback or corrections, please do so either here on the
>> list, or on the page directly (scroll down to "add new comment";
>> leaving comments requires you to log in in an effort to combat comment
>> spam).
>>
>> http://www.hastexo.com/resources/hints-and-kinks/configuring-radosgw-behave-amazon-s3
> 
> Note that for obvious reasons this method can't work when accessing
> the RESTful api via https. It is useful as a workaround for handling
> clients that are hard coded for amazon.

Point taken, I've added a paragraph saying that while technically
feasible, such HTTPS hackery shouldn't be attempted.

>> As a side note, I'm not 100% sure if the information listed in
>> http://ceph.com/docs/master/radosgw/s3/ with respect to S3 API
>> compatibility is entirely accurate. Specifically, it seems that the
>> "Bucket Website" feature *is* supported by way of "rgw dns name"
>> (unless I'm missing something, and Bucket Website refers to something
>> different). Thoughts on that would also be appreciated.
> 
> Yeah, you're missing something. Bucket website is a way to configure a
> bucket to behave like a static website by providing default landing
> page when accessing the bucket's root, and by providing default error
> pages. You can read all about it here:
> 
> http://docs.amazonwebservices.com/AmazonS3/latest/dev/WebsiteHosting.html

Thanks.

Cheers,
Florian
