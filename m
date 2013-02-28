From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rename whilst in use
Date: Thu, 28 Feb 2013 00:40:18 -0800
Message-ID: <512F17F2.4030304@inktank.com>
References: <512E0347.4040009@risc-software.at> <512E823C.4080902@inktank.com> <512EF29E.9050802@risc-software.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:49077 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab3B1Ij7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Feb 2013 03:39:59 -0500
Received: by mail-da0-f48.google.com with SMTP id w4so752940dam.35
        for <ceph-devel@vger.kernel.org>; Thu, 28 Feb 2013 00:39:59 -0800 (PST)
In-Reply-To: <512EF29E.9050802@risc-software.at>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Cc: ceph-devel@vger.kernel.org

On 02/27/2013 10:01 PM, Wolfgang Hennerbichler wrote:
> On 02/27/2013 11:01 PM, Josh Durgin wrote:
>
>> Since it doesn't appear in rbd ls, this suggests that the old
>> rbd_id.mysql3 object still exists.
>
> Yes. Is there a way I can safely delete it?
>
> rados ls -p rd | grep mysql | less
> mysql3.rbd
> rbd_id.mysql3.new
>
> => here it is (and yes, it's format==1). can I just say rados rm ...
> without having to fear that everything breaks down?

If you've just had this problem with a format 1 image, you can safely
rados rm the old header (oldname.rbd). It's the only thing that wouldn't
be cleaned up by a rename while it's in use.

>>> unfortunately my scrollback buffer isn't long enough to find out about
>>> the actual error I got during the first rename, but it should be easy to
>>> reproduce.
>>
>> I can't reproduce it (at least not with format 2 images). Can you?
>
> I currently only have this production system to play, so I can't really
> try. but you're right, it's a format 1 image. (that was the use case, I
> tried to "convert" a format 1 image to a format 2 image by creating the
> .new and copying stuff over)
>
>> I'd expect this problem with format 1 images, since they don't separate
>> the header object from the name of the image.
>
> so true. :)
>
>> Thanks, it certainly seems like a bug.
>
> as it's a format==1 bug, maybe it's of less importance. so: is rados rm
> mysql3.rbd a good idea? :)

If mysql3 is the old name of the image that was renamed while in use,
yes.

>> Josh
>
> Wolfgang
>
> PS: I didn't receive mails (even not your reply) on the mailing-list for
> about 12 hours, did your mailserver break? Is your mailserver backed by
> ceph-fs? :)

Not yet :) I'm not sure why that happened, I didn't notice any issues
with vger or my other emails today.
