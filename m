From: Christophe Le Guern <c35sys@gmail.com>
Subject: Re: ListBuckets works but PutObject does not
Date: Fri, 18 Jan 2013 14:22:43 +0100
Message-ID: <CAFpvEKkiRzH+d0ZXKurkxzN+q=HuJ_1i6xuw6KMPyFSzgXPixg@mail.gmail.com>
References: <CAJVE5RX+MWwjp3FFJn4jr99s87MW-cvzPRsxNBuF89==PyoOaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:48475 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab3ARNWo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 08:22:44 -0500
Received: by mail-ia0-f177.google.com with SMTP id h8so1351287iaa.8
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 05:22:43 -0800 (PST)
In-Reply-To: <CAJVE5RX+MWwjp3FFJn4jr99s87MW-cvzPRsxNBuF89==PyoOaA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cesar Mello <cmello@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jan 18, 2013 at 2:01 PM, Cesar Mello <cmello@gmail.com> wrote:
> I've noticed the ListBuckets sample sends an http request to the URL
> ubuntu1, which works. (ubuntu1 is the host name of the apache
> machine). But the PutBucket sample sends an http request to
> 'my-new-mucket.ubuntu1', and this does not get resolved. So I'm
> currently investigating the apache config.
>
> (I'm a Windows guy not very used to apache and Linux, sorry).
>
> Any suggestions are appreciated, but I'm sure I can work out this
> before my vacation ends. :-)

Hi Cesar,

I used dnsmasq and wildcard for the DNS part. (e.g. *.ubuntu1 for you).
You can install it on your linux server then point your client to use
dnsmasq as your resolver.

Christophe
