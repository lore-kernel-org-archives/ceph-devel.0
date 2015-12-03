From: Robert LeBlanc <robert@leblancnet.us>
Subject: Undefined Ref for simple prog
Date: Thu, 3 Dec 2015 15:40:35 -0700
Message-ID: <CAANLjFrbaa=wC=9tk9_w_ROxDF-yityFNRf=zBkrb6b0gA0gmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33746 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbbLCWkg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 17:40:36 -0500
Received: by vkca188 with SMTP id a188so55484743vkc.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 14:40:35 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I'm trying to do some testing of Ceph components specifically around
the OP queues. I'm trying to use the class in a simple program where I
will do my testing, but I can't resolve one problem. I've had to
include  types.h as forward defining the Formatter class (already
included/forward defined in the base class). This is based on my PR
https://github.com/ceph/ceph/pull/6781 .

//wrr_bench.cc
// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
// vim: ts=8 sw=2 smarttab

#include "include/types.h"
#include "common/PrioritizedQueue.h"
#include

//namespace ceph {
//  class Formatter;
//}

int main() {
  PrioritizedQueue pq(0,0);
  std::cout << "Running.." << std::endl;
}

I'm compiling with:
$ g++ -std=c++11 -I. wrr_bench.cc -o wrr_bench
/tmp/ccf6wRFo.o: In function `PrioritizedQueue::length() const':
wrr_bench.cc:(.text._ZNK16PrioritizedQueueIjjE6lengthEv[_ZNK16PrioritizedQueueIjjE6lengthEv]+0x5a):
undefined reference to `ceph::__ceph_assert_fail(char const*, char
const*, int, char const*)'
wrr_bench.cc:(.text._ZNK16PrioritizedQueueIjjE6lengthEv[_ZNK16PrioritizedQueueIjjE6lengthEv]+0xfb):
undefined reference to `ceph::__ceph_assert_fail(char const*, char
const*, int, char const*)'
/tmp/ccf6wRFo.o: In function `PrioritizedQueue::empty() const':
wrr_bench.cc:(.text._ZNK16PrioritizedQueueIjjE5emptyEv[_ZNK16PrioritizedQueueIjjE5emptyEv]+0x2e):
undefined reference to `ceph::__ceph_assert_fail(char const*, char
const*, int, char const*)'
wrr_bench.cc:(.text._ZNK16PrioritizedQueueIjjE5emptyEv[_ZNK16PrioritizedQueueIjjE5emptyEv]+0x68):
undefined reference to `ceph::__ceph_assert_fail(char const*, char
const*, int, char const*)'
/tmp/ccf6wRFo.o: In function `PrioritizedQueue::dequeue()':
wrr_bench.cc:(.text._ZN16PrioritizedQueueIjjE7dequeueEv[_ZN16PrioritizedQueueIjjE7dequeueEv]+0x3b):
undefined reference to `ceph::__ceph_assert_fail(char const*, char
const*, int, char const*)'
/tmp/ccf6wRFo.o:wrr_bench.cc:(.text._ZN16PrioritizedQueueIjjE7dequeueEv[_ZN16PrioritizedQueueIjjE7dequeueEv]+0x1b0):
more undefined references to `ceph::__ceph_assert_fail(char const*,
char const*, int, char const*)' follow
collect2: error: ld returned 1 exit status

Including assert.h doesn't help. Any pointers?

Thanks,

- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWYMTfCRDmVDuy+mK58QAACdUP/RkhdAhkYLM9jzEXss8b
Z003Cz1jnEe9sw+xsMdvaQxU/d0RbhE1Mst1HvfAv9aFCjJbtUf5dYyqCy/6
SnTWIPe79kEVJ61ATTSSbQGCDkMJZiONrnhc2IDdrY4b5N04kYRlG6jQfCr4
s/k7cnu2ReTjIRtQzr+SmAtaqcNt2OyMGjt6Aa+Wu+MyoZ5Z2ELBo63LrjPu
SSVBtKXSajXjz827broyA5zsejLrJzlww0UkwMCwFWZ6bHxKjRD5Xj4r15j0
zh3HcRZZAJk2F7nePXKlpZfh96xmDbc3RJ4HY4ZvYCxxrprFfw9LJ/yE6qix
TfvYMJIeKldQkG8vmNJKrKXQx9Lc1o32uCnOu1A9MMzA9tC4HrHFq69/IvcW
SUMlXqxzw3KPA0PxYwvxCOy3PUMwtAfofZOmBeMCIpIuRJbY+YXhJz55/a7m
8FEC1b7+MR54tpNOuaMeTXjmf5v1ddcMaTMO6L61YMKRoBFLHHMWVeuYeNxt
okzvEnFWvkCvM0bEGMVFt038h3k7BpuxTe0FypKtAUpR1lgvsVKLWMP1y9ai
XRqDB1eV13zxY/LIM3OlXbCDZFgWvycBrRQpScuYJ08SivkSg7ya5q85W4/J
7Bpy5W7HgmUbN+fzqMZ/VPW52ys7fHiWDQRmULR7V35rnngvkQoIBcEmWLPd
mEsp
=N4vu
-----END PGP SIGNATURE-----
