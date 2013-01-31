From: Gregory Farnum <greg@inktank.com>
Subject: Re: Paxos and long-lasting deleted data
Date: Thu, 31 Jan 2013 10:56:36 -0800
Message-ID: <CAPYLRzieYDDOrbpj_Cs0czxA3uFrLez6A5gKdQoMFT2dyA9vqA@mail.gmail.com>
References: <CABYiri8fbbpuhh0RguqdsmYEbEkYz_+PKO4UJqWqKb1TwDcc6A@mail.gmail.com>
	<CAPYLRzjwn4LxnzbX9SBJL7x7AtX6=pmv84HXBGykNGHn7zVLTA@mail.gmail.com>
	<CABYiri82rCvVD79rnhm3mFPoegnF7w4SNyUrFr+axEoty69n1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:58987 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab3AaS4h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 13:56:37 -0500
Received: by mail-qa0-f46.google.com with SMTP id o13so2829694qaj.12
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 10:56:36 -0800 (PST)
In-Reply-To: <CABYiri82rCvVD79rnhm3mFPoegnF7w4SNyUrFr+axEoty69n1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>, Dan Mick <dan.mick@inktank.com>, Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 31, 2013 at 10:50 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
> http://xdel.ru/downloads/ceph-log/rados-out.txt.gz
>
>
> On Thu, Jan 31, 2013 at 10:31 PM, Gregory Farnum <greg@inktank.com> wrote:
>> Can you pastebin the output of "rados -p rbd ls"?


Well, that sure is a lot of rbd objects. Looks like a tool mismatch or
a bug in whatever version you were using. Can you describe how you got
into this state, what versions of the servers and client tools you
used, etc?
-Greg
