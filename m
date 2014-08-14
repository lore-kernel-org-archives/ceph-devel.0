From: Guang Yang <yguang11@outlook.com>
Subject: Re: assert failure
Date: Thu, 14 Aug 2014 10:39:10 +0800
Message-ID: <BLU437-SMTP55D87E766F90EFADF2BDA0DFE80@phx.gbl>
References: <1229494305.20638287.1407961759048.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s35.hotmail.com ([65.55.111.174]:55777 "EHLO
	BLU004-OMC4S35.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752527AbaHNCjW convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Aug 2014 22:39:22 -0400
In-Reply-To: <1229494305.20638287.1407961759048.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Huamin Chen <hchen@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi Huamin,
At least one known issue in 0.80.1 with the same failing pattern has been fixed in the latest 0.80.4 release of firefly. Here is the tracking ticket - http://tracker.ceph.com/issues/8232.

Can you compare the log snippets from within the bug and see if they are the same issue?

Thanks,
Guang

On Aug 14, 2014, at 4:29 AM, Huamin Chen <hchen@redhat.com> wrote:

> Is the following assert failure an known issue?
> 
> msg/Pipe.cc: In function 'int Pipe::connect()' thread 7fed3d2dd700 time 2014-08-13 16:26:06.039799
> msg/Pipe.cc: 1070: FAILED assert(m)
> ceph version 0.80.1 (a38fe1169b6d2ac98b427334c12d7cf81f809b74)
> 1: (Pipe::connect()+0x390e) [0x7feee89cf99e]
> 2: (Pipe::writer()+0x511) [0x7feee89d0fd1]
> 3: (Pipe::Writer::entry()+0xd) [0x7feee89d5d0d]
> 4: (()+0x7df3) [0x7fef336cadf3]
> 5: (clone()+0x6d) [0x7fef32fe63dd]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

