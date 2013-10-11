From: Samuel COZANNET <samnco@gmail.com>
Subject: Erasure Coding & Homomorphic Codes
Date: Fri, 11 Oct 2013 12:43:47 +0200
Message-ID: <CAB31d=39kOv6VD8SwjO-QF-e6jqZY+zHKSOf_1guVAiQdc0qPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:46438 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758019Ab3JKKoH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Oct 2013 06:44:07 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so4043752pdi.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Oct 2013 03:44:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear Ceph,

While discussing @cephdays London about Erasure Coding, one of the
main drawbacks of the technology seemed to be the trade off between
size and computation requirements even on small footprint operations
(concat, append...)

One of my colleagues is currently working on homomorphic encryption,
which is basically a way to encrypt content that provides a very
useful feature: operations made on encrypted content reflects on
unencrypted content.

Say for example that A and B are the unencrypted objects, A' and B'
the encrypted objects, and C = F(A,B) the result of an function
applying on A and B that is homomorphic. Then C' = F(A', B').
A simple example of that would be concatenation. If I have 2 strings A
and B, then decrypting A+B has the same value as A'+B'.

Anyway this made me think that object storage might benefit from such
application if and only if the same principles were also working for
erasure codes and form "Homomorphic Erasure Coding".

Lucky me there seem to be some papers around related to such
application of homomorphic codes:
http://arxiv.org/abs/1008.0064 (pdf: http://arxiv.org/pdf/1008.0064.pdf)
http://blog.notdot.net/2012/08/Damn-Cool-Algorithms-Homomorphic-Hashing
http://www.pdl.cmu.edu/PDL-FTP/SelfStar/podc07.pdf
Or any result on duckduckgo of research
https://duckduckgo.com/?q=homorphic+erasure+code

Not being a coder nor mathematician myself I may of course repeat
something trivial for you guys (and in that case I apologize) but it
seems to me such codes would dramatically improve simple operations on
erasure coded objects, and would make sense...

It's also my first message to the list, let me know if there is any
policy I didn't follow, I'd be happy to comply to best practices...

Hope this opens new ideas...
Best,
Samuel Cozannet
