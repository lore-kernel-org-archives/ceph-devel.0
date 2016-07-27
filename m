From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: static member variable in libcommon and double free
Date: Tue, 26 Jul 2016 17:12:07 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1607261706350.28641@ancalagon.suse.com>
References: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com> <CALe9h7cn19-Rk_RN-F8HtinL8tsoou1-KgczMgT6Jtj9eWKtww@mail.gmail.com> <CAJE9aOOumNu1d3dm0HBL_Zr0_dGdqgdQtqrx00rZoitivXf1=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57689 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045AbcG0AMN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 Jul 2016 20:12:13 -0400
In-Reply-To: <CAJE9aOOumNu1d3dm0HBL_Zr0_dGdqgdQtqrx00rZoitivXf1=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Folks,

I hope this will help.

Three are some issues that you need to know about when you're writing 
computer programs in C++. Before you decide to change away from the whole 
structure, consider what it is currently accomplishing.

Here is one of them. It may be exactly what you're running in to:
https://isocpp.org/wiki/faq/ctors#static-init-order

Please feel free to ask questions.

-Jesse

