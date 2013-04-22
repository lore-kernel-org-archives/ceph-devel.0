From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: poor write performance
Date: Mon, 22 Apr 2013 17:35:06 +0200
Message-ID: <CAF6-1L43eJ1SMqYLC1YzZjZ-qCpdkBfZczmXCxHt0kvGdi7UUA@mail.gmail.com>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
	<516FF893.1030309@inktank.com>
	<6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au>
	<517159C3.5030100@inktank.com>
	<6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au>
	<CAF6-1L4Yxqmq0yED+gA_Xgupzg6AvWi6mBD59-aXYgUj3foaTw@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B4F36261A@BITCOM1.int.sbss.com.au>
	<CAF6-1L5aindF_41=d6JKvut5cBzXx_1btGw-EteGmijoma616A@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B4F3636DC@BITCOM1.int.sbss.com.au>
	<51752156.9050004@inktank.com>
	<alpine.DEB.2.00.1304220815060.14431@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:43596 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296Ab3DVPfI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 11:35:08 -0400
Received: by mail-bk0-f49.google.com with SMTP id w5so525161bku.22
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 08:35:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1304220815060.14431@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> Unless Sylvian implemented this in his tool
> explicitly, it won't happen there either.

The small bench tool submits requests using the asynchronous API as
fast as possible, using a 1M chunk.
Then it just waits for all the completions to be done.

    Sylvain
