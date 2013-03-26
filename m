From: Damien Churchill <damoxc@gmail.com>
Subject: Re: Set object mtime
Date: Tue, 26 Mar 2013 14:48:59 +0000
Message-ID: <CAFtEh-dNzjj5yXmw+qej2a67yRW_YbjPk5uVQKhiK00kFRZysg@mail.gmail.com>
References: <CAFtEh-e6GWeU-hP==zPjcXDuxfWkmeZo0wDwY-R82SJR2JZnzQ@mail.gmail.com>
	<5150A306.6030509@42on.com>
	<CAFtEh-d6r4S+1G1LLhWnzJXhKR1maQXJYrVK8nn+3UjjchoSZw@mail.gmail.com>
	<alpine.DEB.2.00.1303251237090.12444@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:54801 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964786Ab3CZO4I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Mar 2013 10:56:08 -0400
Received: by mail-pb0-f48.google.com with SMTP id wy12so4741763pbc.7
        for <ceph-devel@vger.kernel.org>; Tue, 26 Mar 2013 07:56:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303251237090.12444@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 25 March 2013 19:38, Sage Weil <sage@inktank.com> wrote:
> On Mon, 25 Mar 2013, Damien Churchill wrote:
>> On 25 March 2013 19:18, Wido den Hollander <wido@42on.com> wrote:
>> > On 03/25/2013 12:27 PM, Damien Churchill wrote:
>> >>
>> >> Does anyone know if it's possible to set an objects mtime at all in RADOS?
>> >>
>> >
>> > You mean with a specific operation while not modifying the content of the
>> > object?
>> >
>> > I checked the rados API, but I couldn't find any method which allows you to
>> > do so.
>>
>> Neither could I. I guess the question should be changed to:
>>
>> How difficult would it be to allow the modification time to be set
>> (including setting it to a time in the past) without changing the
>> object?
>
> The CREATE operation just creates the object if it doesn't exist.  You can
> use that op and set the mtime to whatever you want.  You probably need to
> use the C++ bindings with the ObjectWriteOperation method; I don't think
> there is a standalone call for it (tho one is easily added).
>

Okay thanks! A call in the C API would be handy. I was wanting to look
at creating a tool to sync RADOS between clusters. Is that anything
that's in the development plan already? I noticed the email about the
rbd-diff tool yesterday.
