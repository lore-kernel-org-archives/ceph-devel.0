From: Abhishek L <abhishek@suse.com>
Subject: Re: s3website 404 behaviour
Date: Mon, 02 May 2016 22:12:45 +0200
Message-ID: <86zis8p6bm.fsf@suse.com>
References: <87eg9kva62.fsf@suse.com> <robbat2-20160502T174646-839082880Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:49543 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbcEBUNN (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 2 May 2016 16:13:13 -0400
In-reply-to: <robbat2-20160502T174646-839082880Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Robin H. Johnson writes:

> (I'm on the list, no need to mail me directly).
>
> On Mon, May 02, 2016 at 03:53:09PM +0200, Abhishek Lekshmanan wrote:
>> the browser sees a 200 OK and just does a download of an empty file, rgw
>> actually returns a 404 here[1]. I haven't checked the behavior on S3
>> yet, Is there something else that needs to be set in bucket website
>> configuration, or is this something RGW is doing wrong at the moment?
>> [1]: https://gist.github.com/theanalyst/891781582ddc454bafdc5ef7d075ec7a
> What commits are you using?
> You'll need both PR8633 and PR8669 present.
(already mentioned in irc, mentioning here for completeness)

Both of these PRs weren't yet there in the RGW I was using, I'll apply
these and see how the behaviour is.

Thanks 
Abhishek
