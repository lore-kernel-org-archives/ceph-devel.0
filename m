From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Optimization Analysis Tool
Date: Mon, 3 Jul 2017 22:50:23 +0530
Message-ID: <CAAXqJ+qsutkbJZTCRbvR=yuNjVX5n_Vk9V=XEBUa8dmKefhEzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36708 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755472AbdGCRUa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jul 2017 13:20:30 -0400
Received: by mail-wm0-f50.google.com with SMTP id 62so175023925wmw.1
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jul 2017 10:20:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>, kefu chai <tchaikov@gmail.com>

Hi everyone.

As a part of GSoC, I will be implementing a tool, to analyse the need
of reweighting devices in the crushmap, and assign a score to the
reweight-by-utilisation algorithm. Please correct me where I am wrong,
and any other suggestions are more than welcome.

The tool shall be a python module, in /src/pybind/mgr and it will use
Ceph's current python mgr module to get "pg_summary".

The parameters that I plan to use are:
* The devices utilisation
  The number of over-filled devices along with the the amount of
over-filled%, will generate a score, using t-distribution. The reason,
I shall consider only over-filled devices is because one 10%
underfilled with 5 2% overfilled devices, is arguably a better
situation than one 10% overfilled with 5 2% underfilled devices. The
data for expected distribution after optimization can be obtained from
python-crush module.

* Expected amount of data flow over the network
  A score for it can be predicted, using the number of PGs that will
be swapped during optimization, which can be found in python-crush[1].
However, the number of PGs, might not give a better idea about the
amount of data flow, over the network. Hence, using python mgr-module,
and obtaining pgmap before and after each optimization step, will give
the amount of data flow in the network.

* Time for optimization process
 This will simply keep a note of the time taken to produce an
optimized crushmap from the existing one.

I would be using data from python-crush[2] and from pg_map (in json
format) obtained by sending commands to python mgr module, to gather
the values for the required parameters. A weighted combination of this
shall determine the score for the optimization algorithm in place.

My initial target is to output the results into a file. I would try to
merge it with the dashboard plugin in mgr module, after the
implementing the tool at first.

[1]: http://libcrush.org/main/python-crush/blob/master/tests/test_optimize.py#L460
[2]:http://libcrush.org/main/python-crush/blob/master/

-- 
Spandan Kumar Sahu
IIT Kharagpur
