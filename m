From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: AttributeError: 'Rados' object has no attribute 'monitor_log'
Date: Thu, 7 Jul 2016 08:46:26 +1000
Message-ID: <CAF-wwdG5-NSDT2YDBWk_cNSU7vzajv9EQ75GZ99qSQJBUbjVkQ@mail.gmail.com>
References: <30f6bbac-0b8b-b241-b58d-e3960051ad7c@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35645 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779AbcGFWq3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jul 2016 18:46:29 -0400
Received: by mail-wm0-f52.google.com with SMTP id z126so127993812wme.0
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jul 2016 15:46:28 -0700 (PDT)
In-Reply-To: <30f6bbac-0b8b-b241-b58d-e3960051ad7c@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 7, 2016 at 3:22 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> I'm trying to run cephtool-test-mon.sh, and it gets there quite far
> but somewhere down the test I have this error:
> Now python is not my strong point.

Not mine either but monitor_log should be defined in
src/pybind/rados/rados.pyx and within the
"Rados" object definition.

 519 cdef class Rados(object):
...
1280     def monitor_log(self, level, callback, arg):

I guess just checking they are there is a start :)

HTH,
Brad

>
> Where should I start looking?
>
> --WjW
>
> /home/wjw/Ceph/work.cmake/ceph/qa/workunits/cephtool/test.sh:159:
> ceph_watch_start:  sleep 1
> 5: Traceback (most recent call last):
> 5:   File "/home/wjw/Ceph/work.cmake/ceph/build/bin/ceph", line 948, in
> <module>
> 5:     retval = main()
> 5:   File "/home/wjw/Ceph/work.cmake/ceph/build/bin/ceph", line 775, in main
> 5:     run_in_thread(cluster_handle.monitor_log, level, watch_cb, 0)
> 5: AttributeError: 'Rados' object has no attribute 'monitor_log'
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
