From: "tournier.elie" <tournier.elie@gmail.com>
Subject: [GSoC2016] Interest in implementing RBD diff checksums
Date: Fri, 4 Mar 2016 20:07:12 +0100
Message-ID: <CA+SrN4wDh5SaU9bXBo=LB7LHN4F=3_1zLbZtWXm-Gsqq1_h7WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35973 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758341AbcCDTHN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2016 14:07:13 -0500
Received: by mail-io0-f171.google.com with SMTP id l127so72305676iof.3
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2016 11:07:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone.

My name is Elie TOURNIER, I am a last year undergraduate student
enrolled in a 5 years Medical ICT course at T=C3=A9l=C3=A9com Physiques
Strasbourg, France.
I came to know about the Ceph project and would like to contribute to
"RBD diff checksums subject" as a part of GSoC 2016.
I am fluent in C/C++ and know a bit about cryptography.

I have many ideas but I have some questions too.

So questions:
 1- Is this feature must be integrated to the Ceph code or must be a st=
andalone?
 2- What is the maximum time allowed for the checksum?

My ideas:
 1- Use fast hash algorithm like xxHash [1] or Highwayhash [2] in
order to reduce computation time.
 2- Use the size of the file as a seed.

[1] https://github.com/Cyan4973/xxHash
[2] https://github.com/google/highwayhash

Thank you in advance for yours answers.

Regards,
Elie TOURNIER

PS: If you have any questions, remarks about me or my ideas for the
project, don't hesitate to contact me.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
