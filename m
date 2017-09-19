From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: OSD crashes (10.2.9)
Date: Tue, 19 Sep 2017 17:57:57 +0200
Message-ID: <8c524069-bab4-d8d7-12bc-43d03595f435@suse.cz>
References: <CAGbviv+ivLU6om240hEn=ajGogLYdR1XRmnEaFDYWHyaEzXZWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750990AbdISP6B (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 19 Sep 2017 11:58:01 -0400
In-Reply-To: <CAGbviv+ivLU6om240hEn=ajGogLYdR1XRmnEaFDYWHyaEzXZWw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Ceph Development <ceph-devel@vger.kernel.org>

Which version of leveldb?

On 09/19/2017 05:28 PM, Wyllys Ingersoll wrote:
> Im seeing this stack trace in a lot of my OSDs (21 out of 92).  I
> suspect its a corrupt leveldb or journal, but not sure how to debug it
> further.  Any suggestions on how to debug further?
> 
>   ceph version 10.2.9 (2ee413f77150c0f375ff6f10edd6c8f9c7d060d0)
>   1: (()+0x984c4e) [0x56032b65ec4e]
>   2: (()+0x11390) [0x7f89adce8390]
>   3: (gsignal()+0x38) [0x7f89abc86428]
>   4: (abort()+0x16a) [0x7f89abc8802a]
>   5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x26b) [0x56032b75f0db]
>   6: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d const*, char
> const*, long)+0x259) [0x56032b69b2d9]
>   7: (ceph::HeartbeatMap::is_healthy()+0xe6) [0x56032b69bc06]
>   8: (ceph::HeartbeatMap::check_touch_file()+0x2c) [0x56032b69c45c]
>   9: (CephContextServiceThread::entry()+0x167) [0x56032b777777]
>   10: (()+0x76ba) [0x7f89adcde6ba]
>   11: (clone()+0x6d) [0x7f89abd5782d]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
