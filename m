From: Dietmar Maurer <dietmar@proxmox.com>
Subject: missing health status details
Date: Fri, 22 Nov 2013 10:21:28 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F7559234656@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.maurer-it.com ([94.136.31.133]:51796 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752567Ab3KVKVw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Nov 2013 05:21:52 -0500
Received: from proxmox.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox.maurer-it.com (Proxmox) with ESMTP id C0D95271E827
	for <ceph-devel@vger.kernel.org>; Fri, 22 Nov 2013 11:21:30 +0100 (CET)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Just playing around, and detected this:

# ceph health -f json-pretty

{ "summary": [],
  "timechecks": { "epoch": 34,
      "round": 40,
      "round_status": "finished",
      "mons": [
            { "name": "1",
              "skew": "0.000000",
              "latency": "0.000000",
              "health": "HEALTH_OK"},
            { "name": "0",
              "skew": "-0.000330",
              "latency": "0.001454",
              "health": "HEALTH_OK"},
            { "name": "2",
              "skew": "0.054170",
              "latency": "0.000816",
              "health": "HEALTH_WARN",
              "details": "clock skew 0.0541703s > max 0.05s"}]},
  "health": { "health_services": [
            { "mons": [
                    { "name": "1",
                      "kb_total": 2064208,
                      "kb_used": 1424964,
                      "kb_avail": 534388,
                      "avail_percent": 25,
                      "last_updated": "2013-11-22 11:14:47.500872",
                      "store_stats": { "bytes_total": 9524208,
                          "bytes_sst": 8999282,
                          "bytes_log": 458752,
                          "bytes_misc": 66174,
                          "last_updated": "0.000000"},
                      "health": "HEALTH_WARN",
                      "health_detail": "low disk space!"},
                    { "name": "0",
                      "kb_total": 2064208,
                      "kb_used": 1249116,
                      "kb_avail": 710236,
                      "avail_percent": 34,
                      "last_updated": "2013-11-22 11:14:53.498853",
                      "store_stats": { "bytes_total": 10048528,
                          "bytes_sst": 8999314,
                          "bytes_log": 983040,
                          "bytes_misc": 66174,
                          "last_updated": "0.000000"},
                      "health": "HEALTH_OK"},
                    { "name": "2",
                      "kb_total": 2064208,
                      "kb_used": 1247084,
                      "kb_avail": 712268,
                      "avail_percent": 34,
                      "last_updated": "2013-11-22 11:14:28.720368",
                      "store_stats": { "bytes_total": 10048528,
                          "bytes_sst": 8999314,
                          "bytes_log": 983040,
                          "bytes_misc": 66174,
                          "last_updated": "0.000000"},
                      "health": "HEALTH_OK"}]}]},
  "overall_status": "HEALTH_WARN",
  "detail": [
        "mon.2 addr 192.168.3.13:6789\/0 clock skew 0.0541703s > max 0.05s (latency 0.000815989s)"]}


Why is "low disk space!" not included inside 'details'?

