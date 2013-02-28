From: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Subject: Re: rename whilst in use
Date: Thu, 28 Feb 2013 07:01:02 +0100
Message-ID: <512EF29E.9050802@risc-software.at>
References: <512E0347.4040009@risc-software.at> <512E823C.4080902@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from email.edvz.uni-linz.ac.at ([140.78.3.65]:36167 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723Ab3B1GBF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Feb 2013 01:01:05 -0500
In-Reply-To: <512E823C.4080902@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org



On 02/27/2013 11:01 PM, Josh Durgin wrote:

> Since it doesn't appear in rbd ls, this suggests that the old
> rbd_id.mysql3 object still exists.

Yes. Is there a way I can safely delete it?

rados ls -p rd | grep mysql | less
mysql3.rbd
rbd_id.mysql3.new

=> here it is (and yes, it's format==1). can I just say rados rm ...
without having to fear that everything breaks down?

>> unfortunately my scrollback buffer isn't long enough to find out about
>> the actual error I got during the first rename, but it should be easy to
>> reproduce.
> 
> I can't reproduce it (at least not with format 2 images). Can you?

I currently only have this production system to play, so I can't really
try. but you're right, it's a format 1 image. (that was the use case, I
tried to "convert" a format 1 image to a format 2 image by creating the
.new and copying stuff over)

> I'd expect this problem with format 1 images, since they don't separate
> the header object from the name of the image.

so true. :)

> Thanks, it certainly seems like a bug.

as it's a format==1 bug, maybe it's of less importance. so: is rados rm
mysql3.rbd a good idea? :)

> Josh

Wolfgang

PS: I didn't receive mails (even not your reply) on the mailing-list for
about 12 hours, did your mailserver break? Is your mailserver backed by
ceph-fs? :)

