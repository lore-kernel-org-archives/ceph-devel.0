From: Gregory Farnum <greg@inktank.com>
Subject: Re: Assertion error in librados
Date: Tue, 25 Feb 2014 07:28:30 -0800
Message-ID: <CAPYLRzhnPTEgycnmZ0HXeEW=ADe01QKS8nUmL8451rYYtoMvgw@mail.gmail.com>
References: <20140225144900.GA30739@philipgian-mac>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:62756 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbaBYPgn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 10:36:43 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so555484qaq.11
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 07:36:42 -0800 (PST)
In-Reply-To: <20140225144900.GA30739@philipgian-mac>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Filippos Giannakos <philipgian@grnet.gr>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

Do you have logs? The assert indicates that the messenger got back
something other than "okay" when trying to grab a local Mutex, which
shouldn't be able to happen. It may be that some error-handling path
didn't drop it (within the same thread that later tried to grab it
again), but we'll need more details to track it down.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Tue, Feb 25, 2014 at 6:49 AM, Filippos Giannakos <philipgian@grnet.gr> wrote:
> Hello all,
>
> We recently bumped into the following assertion error in librados on our
> production service:
>
>
> common/Mutex.cc: In function 'void Mutex::Lock(bool)' thread 7fa2c2ccf700 time 2014-02-21 07:23:26.340791
> common/Mutex.cc: 93: FAILED assert(r == 0)
>  ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
>  1: (Mutex::Lock(bool)+0x131) [0x7fa2c7707431]
>  2: (SimpleMessenger::submit_message(Message*, Connection*, entity_addr_t const&, int, bool)+0x52) [0x7fa2c7863172]
>  3: (SimpleMessenger::_send_message(Message*, Connection*, bool)+0x23e) [0x7fa2c7863bfe]
>  4: (Objecter::send_op(Objecter::Op*)+0x32c) [0x7fa2c76b317c]
>  5: (Objecter::handle_osd_map(MOSDMap*)+0x365) [0x7fa2c76b7805]
>  6: (librados::RadosClient::_dispatch(Message*)+0x7c) [0x7fa2c768c70c]
>  7: (librados::RadosClient::ms_dispatch(Message*)+0x9b) [0x7fa2c768c82b]
>  8: (DispatchQueue::entry()+0x4eb) [0x7fa2c7800d2b]
>  9: (DispatchQueue::DispatchThread::entry()+0xd) [0x7fa2c78666ad]
>  10: (()+0x6b50) [0x7fa2c7203b50]
>  11: (clone()+0x6d) [0x7fa2c6b570ed]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion'
>
>
> From what I can tell, there were some network problems on our RADOS cluster,
> after which many of our librados clients failed with the above assertion error.
>
> Do you have any ideas of what might went wrong ?
>
> Kind Regards,
> --
> Filippos
> <philipgian@grnet.gr>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
