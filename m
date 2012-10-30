From: Gregory Farnum <greg@inktank.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 14:15:26 +0100
Message-ID: <CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
	<508EE540.5060303@inktank.com>
	<CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44437 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab2J3NP1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 09:15:27 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so315477iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 06:15:26 -0700 (PDT)
In-Reply-To: <CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

Not a lot of people are publicly discussing their sizes on things like
that, unfortunately. I believe DreamHost is still the most open. They
have an (RGW-based) object storage service which is backed by ~800
OSDs and are currently beta-testing a compute service using RBD, which
you can see described here:
http://www.youtube.com/watch?v=l_8Y988fO44&feature=plcp

On Tue, Oct 30, 2012 at 12:35 PM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2012/10/29 Dan Mick <dan.mick@inktank.com>:
>> There are sites using them in production now.
>
> Any docs about infrastructure size, topology, performance and so on?
>
> I'm evaluating many distribuited system and I would like to have some
> feedbacks/usecase)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
