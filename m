From: tao changtao <changtao381@gmail.com>
Subject: rbd ThreadPool threads number
Date: Thu, 13 Oct 2016 14:56:12 +0800
Message-ID: <CAKT23OLRRLsy=fFJOpC3vqKM1zy0dCLy1nm9zpLov2yqvqb=cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34008 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbcJMG4P (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 02:56:15 -0400
Received: by mail-lf0-f66.google.com with SMTP id x23so5262193lfi.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2016 23:56:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi All=EF=BC=8C

why the rbd ThreadPool  threads number are set 1 by hard code ?


class ThreadPoolSingleton : public ThreadPool {
public:
  explicit ThreadPoolSingleton(CephContext *cct)
    : ThreadPool(cct, "librbd::thread_pool", "tp_librbd", 1,
                 "rbd_op_threads") {
    start();
  }
  virtual ~ThreadPoolSingleton() {
    stop();
  }
};

________________________________
changtao381@gmail.com
