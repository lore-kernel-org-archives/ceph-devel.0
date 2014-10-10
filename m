From: Gregory Farnum <greg@inktank.com>
Subject: Re: why index (collectionIndex) need a lock?
Date: Fri, 10 Oct 2014 09:44:12 -0700
Message-ID: <CAPYLRzg6LGREomg5uGzBvRgVLjBRFd3FtzUx6xU+W9AAS12-bQ@mail.gmail.com>
References: <CALZt5jwhBNifcagmsGBZiEC99Q0TvDFPy45f05hidVZedKEK-w@mail.gmail.com>
	<CAPYLRzg=y1YKsZAACdwT08UiSVf_wZ8G1TFa7MYLOu8xV-fZyw@mail.gmail.com>
	<CALZt5jzOb5UfkJheWDukmAXQG-iv+5ujCQZsNzc6U_xJeGXH=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:45030 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbaJJQoN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 12:44:13 -0400
Received: by mail-qa0-f50.google.com with SMTP id w8so1910960qac.9
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 09:44:12 -0700 (PDT)
In-Reply-To: <CALZt5jzOb5UfkJheWDukmAXQG-iv+5ujCQZsNzc6U_xJeGXH=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicheal <zay11022@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

[ Please keep stuff on the list; we don't do private emails and you'll
get faster responses. ]

I don't know for this particular case, but I think it's just an
invariant for all FileStore operations. There's a lot of random stuff
that can go into the omap; it's user-accessible.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com

On Tue, Oct 7, 2014 at 7:37 PM, Nicheal <zay11022@gmail.com> wrote:
> Thanks, I got your concept.
> I find that the Index Ref will be obtained before omap_setkeys (calle=
d
> function lfn_find). However, the path is not used in function
> omap_setkeys. So why we prevent the Collection (merge or split) when
> modifying omap keys? Actually, the information in omap is pg_log,
> pg_info, and sometimes, object XATTR, right?
>
> 2014-10-01 1:23 GMT+08:00 Gregory Farnum <greg@inktank.com>:
>> On Tue, Sep 30, 2014 at 12:08 AM, Nicheal <zay11022@gmail.com> wrote=
:
>>> Dear develops,
>>>
>>> I go through the files (hashIndex, LFNIndex and CollectionIndex), I
>>> cannot find any parameters need to grasp a lock. And basically,
>>> (hashIndex, LFNIndex and CollectionIndex) is used to manage a
>>> collection of objects.
>>>
>>> Thus, just in one case, when the spilt or merge is on going, then
>>> lookup() path function is called to get the object path. It may obt=
ain
>>> a wrong path, right?
>>>
>>> If so, why not using a state parameter in the class CollectionIndex=
 or
>>> HashIndex indicating the current state of this collection (split,
>>> merge on going or none) and grasp a lock when the state changes. Wh=
y
>>> always lock the index before lookup() path or lfn_find()?
>>>
>>> Any other reasons?
>>
>> Well, you've just named why we have the lock =E2=80=94 it's to preve=
nt
>> multiple users simultaneously making changes to the *filesystem* tha=
t
>> we can't handle. In particular, no simultaneous ops can run against
>> the same Collection. This is to prevent situations where a reader
>> comes in and builds up the path for an object it needs to look at,
>> then a writer creates a new file which initiates collection split an=
d
>> the reader's path is suddenly invalid.
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
