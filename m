From: Samuel Cozannet <samuel.cozannet@h-t-solutions.com>
Subject: Erasure Coding & Homomorphic Codes
Date: Fri, 11 Oct 2013 12:48:56 +0200
Message-ID: <CAG0JQVc4Jqz82oqZ=87nORnHuTxUdhY2=+GTLtP83Naxo=OGAw@mail.gmail.com>
Reply-To: samuelc@doremitechno.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:47604 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753445Ab3JKKtT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Oct 2013 06:49:19 -0400
Received: by mail-vc0-f176.google.com with SMTP id ik5so629750vcb.21
        for <ceph-devel@vger.kernel.org>; Fri, 11 Oct 2013 03:49:16 -0700 (PDT)
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
