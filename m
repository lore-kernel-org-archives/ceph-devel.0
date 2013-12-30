From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Apache httpd directives for rgw
Date: Mon, 30 Dec 2013 15:46:56 -0800
Message-ID: <CAC-hyiEvNEcx2aOuZSugykTz-f0dHw+iW=ccSnspcnHMrbUDNQ@mail.gmail.com>
References: <CAOGLoJPPiaRRYvJ8ZaDr5LevBBtOZyz=6CFiinx8bG2hEX9Hzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:48835 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246Ab3L3Xq6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Dec 2013 18:46:58 -0500
Received: by mail-la0-f53.google.com with SMTP id mc6so5957449lab.12
        for <ceph-devel@vger.kernel.org>; Mon, 30 Dec 2013 15:46:56 -0800 (PST)
In-Reply-To: <CAOGLoJPPiaRRYvJ8ZaDr5LevBBtOZyz=6CFiinx8bG2hEX9Hzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Justin Erenkrantz <justin@erenkrantz.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Dec 30, 2013 at 12:19 PM, Justin Erenkrantz
<justin@erenkrantz.com> wrote:
> Hi ceph-devel@,
>
> As a note, I've upstreamed functionality similar to the ones in the
> ceph/apache2 repository.  In particular, you'd use:
>
> HttpContentLengthHeadZero on
> HttpExpectStrict off
>
> For the upstream commit:
> http://svn.apache.org/viewvc?view=revision&revision=1554303

Looks good to me. It'd be nice having these changes upstream.

Yehuda

>
> And, for those that only like GitHub URLs:
> https://github.com/apache/httpd/commit/1a950459084dbbceeff441f7fff1d03bdadddd03
>
> On dev@httpd, we're still discussing whether the default
> HttpContentLengthHeadZero functionality should be on or off.  I think
> it should be "on"...
>
> After that conversation dies down, I'll probably propose it for
> backport to 2.4...but, it changes the MMN (in theory), so it may not
> be able to be properly released until 2.6.  We'll see.
>
> Cheers.  -- justin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
