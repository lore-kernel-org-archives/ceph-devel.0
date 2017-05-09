From: Casey Bodley <cbodley@redhat.com>
Subject: boost::future and continuations
Date: Tue, 9 May 2017 10:16:18 -0400
Message-ID: <457eab81-262e-c7f1-44e2-916dbfa3b4cb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35047 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbdEIOQU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 10:16:20 -0400
Received: by mail-qt0-f175.google.com with SMTP id n4so1742916qte.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 May 2017 07:16:20 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id k10sm54266qke.3.2017.05.09.07.16.19
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 May 2017 07:16:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

I recently discovered that the Boost.Thread library implements some 
extensions to boost::future from the 'Technical Specification for C++ 
Extensions for Concurrency' [1]. The std::experimental interfaces are 
documented on cppreference.com [2], but neither gcc nor clang provide them.

The coolest new feature is future::then(), which takes a continuation to 
be called once the future is ready, and returns a future for the 
continuation's result. This allows futures to be composed into 
higher-level asynchronous operations - an ability that is sorely lacking 
in the c++11 std::future.

While these extensions are not enabled in boost by default, they can be 
turned on with a series of BOOST_THREAD_PROVIDES_FUTURE* defines (since 
boost 1.57). The boost documentation for 'Conformance and Extension' 
[3]describes the status of this implementation, listing some features as 
'partial'. I wrote a set of unit tests to explore this, and was happy 
with the results. The only unfortunate piece missing is 'implicit 
unwrapping' for future::then() - if you pass it a continuation that 
returns a future<T>, then() will return a future<future<T>>. This 
-should- be implicitly converted to future<T>, but boost::future 
requires you to do it explicitly by calling future::unwrap().

I'm curious to see how people feel about this. Would you consider using 
boost::futures? Are there concerns about using boost extensions? About 
slight changes to interfaces? I opened a pull request [4] for discussion 
- take a look at the unit tests for examples, and let me know what you 
think.

Thanks,
Casey

[1] http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/p0159r0.html
[2] http://en.cppreference.com/w/cpp/experimental/concurrency
[3] 
http://www.boost.org/doc/libs/1_63_0/doc/html/thread/compliance.html#thread.compliance.cxx1y
[4] https://github.com/ceph/ceph/pull/14987
