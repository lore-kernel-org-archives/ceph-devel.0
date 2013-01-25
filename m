From: Cesar Mello <cmello@gmail.com>
Subject: Re: radosgw
Date: Thu, 24 Jan 2013 22:24:18 -0200
Message-ID: <CAJVE5RVi_fODAj1Ja2V8iObB4W1Nd=HhwFat23c8fyeo5f1Yyw@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
	<CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
	<CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
	<CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
	<CAJH6TXgbEfJTAHBZE0GfDbzPH8ys8sFAQLn2+zxfxtLkppvQUA@mail.gmail.com>
	<CAJH6TXh68YA2=Dc86==21LjOtAfiZHSzXRgxMPtepw2TBV_tyQ@mail.gmail.com>
	<CAC-hyiE2i_p3AWA11o8rLRJEXUNyoYmhSri861Sk-M=TeuZXcg@mail.gmail.com>
	<CAJH6TXgYCA4oZXOocTcTC_oZEm=nsV-YB4K9vSW9pN6-32ORdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:39116 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab3AYAYT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 19:24:19 -0500
Received: by mail-vc0-f178.google.com with SMTP id m8so8336297vcd.9
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 16:24:18 -0800 (PST)
In-Reply-To: <CAJH6TXgYCA4oZXOocTcTC_oZEm=nsV-YB4K9vSW9pN6-32ORdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org

Just as a curiosity, I lost some time because I didn't read this:

.. important:: Check the key output. Sometimes ``radosgw-admin``
   generates a key with an escape (``\``) character, and some clients
   do not know how to handle escape characters. Remedies include
   removing the escape character (``\``), encapsulating the string
   in quotes, or simply regenerating the key and ensuring that it
   does not have an escape character.

Best regards
Mello

On Thu, Jan 24, 2013 at 8:10 PM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2013/1/23 Yehuda Sadeh <yehuda@inktank.com>:
>> You mean a radosgw user?
>
> This command:
> radosgw-admin user create --uid=johndoe --display-name="John Doe"
> --email=john@example.com
>
> should be ran on radosgw node or on ceph node?
> Because I'm able to create the user, but unable to authenticate with
> any S3 client (I receive a 403 error)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
