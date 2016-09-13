From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Mismatching nonce for 'ceph osd.0 tell'
Date: Tue, 13 Sep 2016 22:29:45 +0200
Message-ID: <3df7e2ed-eb34-8ba8-8a8d-9d7b66e45315@digiware.nl>
References: <f54dda71-dabf-cab2-948c-83b9f2007aff@digiware.nl>
 <CACJqLybyu1_rKj7g7qSfrtZCVMhJvgcvU2Q7vfoRUvs-3hT3JQ@mail.gmail.com>
 <14688c37-068c-0bc6-615d-de2f8f5bfdc6@digiware.nl>
 <CAJ4mKGawPKP=rGB9t1wkwn00sYcBE8T9ac327mGLv90Z4MFxpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43307 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbcIMUaA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 16:30:00 -0400
In-Reply-To: <CAJ4mKGawPKP=rGB9t1wkwn00sYcBE8T9ac327mGLv90Z4MFxpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 13-9-2016 21:52, Gregory Farnum wrote:
> Is osd.0 actually running? If so it *should* have a socket, unless
> you've disabled them somehow. Check the logs and see if there are
> failures when it gets set up, I guess?
> 
> Anyway, something has indeed gone terribly wrong here. I know at one
> point you had some messenger patches you were using to try and get
> stuff going on BSD; if you still have some there I think you need to
> consider them suspect. Otherwise, uh...the network stack is behaving
> very differently than Linux's?

So what is the expected result of an osd down/up?

Before it is connected to ports like:
	127.0.0.1:{6800,,6801,6802}/{nonce=pid-like}
after the osd has gone down/up the sockets work be:
	127.0.0.1:{6800,,6801,6802}/{(nonce=pid-like)+1000000}

or are the ports also incremented?

--WjW


