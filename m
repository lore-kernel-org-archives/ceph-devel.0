From: Cesar Mello <cmello@gmail.com>
Subject: Re: ListBuckets works but PutObject does not
Date: Fri, 18 Jan 2013 11:35:23 -0200
Message-ID: <CAJVE5RVYzm=FigqP2+RQM3-isRi80RTte+P__9bFvmA66w5s6Q@mail.gmail.com>
References: <CAJVE5RX+MWwjp3FFJn4jr99s87MW-cvzPRsxNBuF89==PyoOaA@mail.gmail.com>
	<CAFpvEKkiRzH+d0ZXKurkxzN+q=HuJ_1i6xuw6KMPyFSzgXPixg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:36960 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab3ARNfZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 08:35:25 -0500
Received: by mail-la0-f52.google.com with SMTP id ee20so1770969lab.11
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 05:35:23 -0800 (PST)
In-Reply-To: <CAFpvEKkiRzH+d0ZXKurkxzN+q=HuJ_1i6xuw6KMPyFSzgXPixg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christophe Le Guern <c35sys@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Christophe,

Thank you so much, the problem seemed to be just the DNS.

Now the Windows client connects, but I'm getting a "MethodNotAllowed"
response for the PutBucket request. Progress!

Best regards!
Cesar

On Fri, Jan 18, 2013 at 11:22 AM, Christophe Le Guern <c35sys@gmail.com> wrote:
> On Fri, Jan 18, 2013 at 2:01 PM, Cesar Mello <cmello@gmail.com> wrote:
>> I've noticed the ListBuckets sample sends an http request to the URL
>> ubuntu1, which works. (ubuntu1 is the host name of the apache
>> machine). But the PutBucket sample sends an http request to
>> 'my-new-mucket.ubuntu1', and this does not get resolved. So I'm
>> currently investigating the apache config.
>>
>> (I'm a Windows guy not very used to apache and Linux, sorry).
>>
>> Any suggestions are appreciated, but I'm sure I can work out this
>> before my vacation ends. :-)
>
> Hi Cesar,
>
> I used dnsmasq and wildcard for the DNS part. (e.g. *.ubuntu1 for you).
> You can install it on your linux server then point your client to use
> dnsmasq as your resolver.
>
> Christophe
