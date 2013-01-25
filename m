From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: radosgw
Date: Fri, 25 Jan 2013 14:59:20 +0100
Message-ID: <CAJH6TXiofwTBY=e9TkOrK+a48O3q=Unqp1M4MX=8xbBL06sXXQ@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
	<CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
	<CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
	<CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
	<CAJH6TXgbEfJTAHBZE0GfDbzPH8ys8sFAQLn2+zxfxtLkppvQUA@mail.gmail.com>
	<CAJH6TXh68YA2=Dc86==21LjOtAfiZHSzXRgxMPtepw2TBV_tyQ@mail.gmail.com>
	<CAC-hyiE2i_p3AWA11o8rLRJEXUNyoYmhSri861Sk-M=TeuZXcg@mail.gmail.com>
	<CAJH6TXgYCA4oZXOocTcTC_oZEm=nsV-YB4K9vSW9pN6-32ORdg@mail.gmail.com>
	<CAJVE5RVi_fODAj1Ja2V8iObB4W1Nd=HhwFat23c8fyeo5f1Yyw@mail.gmail.com>
	<CAJH6TXj-4RWMnJKOm5pxjYZkVLaNh9KRR4dOyYu8sJsZOz7jFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:64999 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3AYN7W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 08:59:22 -0500
Received: by mail-wi0-f169.google.com with SMTP id hq12so1471654wib.4
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jan 2013 05:59:20 -0800 (PST)
In-Reply-To: <CAJH6TXj-4RWMnJKOm5pxjYZkVLaNh9KRR4dOyYu8sJsZOz7jFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cesar Mello <cmello@gmail.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org

2013/1/25 Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>:
> Is not my case bacause my key is accepted propery (i'm able to list
> and create buckets)
> my issue seems to be related to the header 100-Continue.
> Without
>
> rgw print continue = false
>
> i'm receiving error 500
>
> with
>
> rgw print continue = false
>
> i recieve duplicate header status (and then error 500)


I've also tried with SetEnv RGW_PRINT_CONTINUE=Off in my radosgw
virtualhost, but duplicate header is still added.
