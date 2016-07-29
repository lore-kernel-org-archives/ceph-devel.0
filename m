From: Adam Kupczyk <akupczyk@mirantis.com>
Subject: Plugins unification
Date: Fri, 29 Jul 2016 14:40:40 +0200
Message-ID: <CAHMeWhGepAWaeec1wLQoRgV5yAtJ0Jg8FXu65sR43RREtbcqFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37105 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbcG2Mkm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 08:40:42 -0400
Received: by mail-wm0-f50.google.com with SMTP id i5so150320146wmg.0
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 05:40:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi cephers,

I plan to unify ceph plugins.

Currently we have 2 plugin trees:
1) erasure-code/ErasureCodePluginRegistry
type of plugin: class ErasureCodePlugin
instances:      class ErasureCodePluginJerasure
                class ErasureCodePluginSelectJerasure
                class ErasureCodePluginLrc
                class ErasureCodePluginSelectShec
                class ErasureCodePluginShec
2) common/PluginRegistry
type of plugin: class Plugin
specialization: class CompressionPlugin
instances:        class CompressionPluginSnappy
                class CompressionPluginZlib
future:
specialization: class CryptoPlugin
instances:        class CryptoPluginISAL

The plan:
1) Get rid of EraseCodePluginRegistry.
2) Make EraseCodePlugin a specialization of class Plugin.
3) PluginRegistry will use ceph configuration for places to search for plugins.
4) PluginRegistry.load(...) will no longer get directory to search.
5) PluginRegistry will only return std::shared_ptr<Plugin> references.
6) PluginRegistry.remove(...) will only delete internal std::shared_ptr<Plugin>.
   Actual dlclose() will be delayed until all references are deleted.
7) static EraseCodePlugin::factory(...), the replacement of
EraseCodePluginRegistry::factory(...)
   will return std::dynamic_pointer_cast<EraseCodePlugin>(located_plugin)
8) Extend class Plugin to force instances to provide "type" and "name".


I would really enjoy comments if such unification is beneficial, and
comments what should be done better.

Best Regards,
Adam Kupczyk
