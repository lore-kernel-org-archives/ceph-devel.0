From: Dan Mick <dan.mick@inktank.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Mon, 15 Apr 2013 15:25:25 -0700
Message-ID: <516C7E55.1050801@inktank.com>
References: <loom.20130412T055215-88@post.gmane.org> <51683184.9010301@inktank.com> <CAJH6TXgurT4yUshaH4QOgUKOaB3DqQd1-=HPshp+eH5HB7p3Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:49024 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab3DOWZ3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 18:25:29 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so2779297pbc.16
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 15:25:28 -0700 (PDT)
In-Reply-To: <CAJH6TXgurT4yUshaH4QOgUKOaB3DqQd1-=HPshp+eH5HB7p3Hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On 04/15/2013 01:06 PM, Gandalf Corvotempesta wrote:
> 2013/4/12 Mark Nelson <mark.nelson@inktank.com>
>
>> Currently reads always come from the primary OSD in the placement group
>> rather than a secondary even if the secondary is closer to the client.
>>
>
> In this way, only one OSD will be involved in reading an object, this will
> result in a bottleneck if multiple clients needs to access to the same file.
>
> For example, a 3KB CSS file served by a webserver to 400 users, will be
> read just from one OSD. 400 users directed to 1 OSD  while (in case of
> replica 3) other 2 OSDs are available?

Yes.  Consistency across the cluster is dependent on this scheme, currently.

