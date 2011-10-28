From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/1] Use a common xml type for ceph secret usage.
Date: Fri, 28 Oct 2011 16:03:48 -0600
Message-ID: <4EAB26C4.9030103@redhat.com>
References: <fc9aba44da7d8be72fabeba1caf07901aaef202d.1319836201.git.josh.durgin@dreamhost.com> <ce9e6885af6aa76edcebca9103a5690447e8dc47.1319835863.git.josh.durgin@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15758 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583Ab1J1WD4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 Oct 2011 18:03:56 -0400
In-Reply-To: <ce9e6885af6aa76edcebca9103a5690447e8dc47.1319835863.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On 10/28/2011 03:19 PM, Josh Durgin wrote:
> The types used in domaincommon.rng and secret.rng should be the same.
>
> Signed-off-by: Josh Durgin<josh.durgin@dreamhost.com>
> ---
>   docs/schemas/domaincommon.rng |   11 ++++++++---
>   docs/schemas/secret.rng       |    4 +++-
>   2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/docs/schemas/domaincommon.rng b/docs/schemas/domaincommon.rng
> index 3477351..d053489 100644
> --- a/docs/schemas/domaincommon.rng
> +++ b/docs/schemas/domaincommon.rng
> @@ -2558,13 +2558,13 @@
>           <attribute name='uuid'>
>             <ref name="UUID"/>
>           </attribute>
> -<attribute name="usage">
> -<ref name="genericName"/>
> +<attribute name='usage'>
> +<ref name='usageName'/>

genericName is probably fine instead of inventing usageName; but I'll 
graduate it out of domaincommon.rng into basictypes.rng.

>           </attribute>
>         </choice>
>       </element>
>     </define>
> -
> +

Spurious whitespace change.

> +++ b/docs/schemas/secret.rng
> @@ -4,6 +4,8 @@
>       <ref name='secret'/>
>     </start>
>
> +<include href='domaincommon.rng'/>

domaincommon.rng is rather heavyweight; basictypes.rng is better.

> +
>     <define name='secret'>
>       <element name='secret'>
>         <optional>
> @@ -60,7 +62,7 @@
>         <value>ceph</value>
>       </attribute>
>       <element name='name'>
> -<text/>
> +<ref name='usageName'/>
>       </element>
>     </define>

At any rate, once we include common types, we can stop repeating the 
UUID definition too.

Not quite like your original patch, but I'll go ahead and squash this 
in, then push in your name since it matches up with your intent.


diff --git i/docs/schemas/basictypes.rng w/docs/schemas/basictypes.rng
index b3267f5..3b4b952 100644
--- i/docs/schemas/basictypes.rng
+++ w/docs/schemas/basictypes.rng
@@ -97,6 +97,12 @@
      </choice>
    </define>

+  <define name="genericName">
+    <data type="string">
+      <param name="pattern">[a-zA-Z0-9_\+\-]+</param>
+    </data>
+  </define>
+
    <define name="dnsName">
      <data type="string">
        <param name="pattern">[a-zA-Z0-9\.\-]+</param>
diff --git i/docs/schemas/domaincommon.rng w/docs/schemas/domaincommon.rng
index d053489..b6f858e 100644
--- i/docs/schemas/domaincommon.rng
+++ w/docs/schemas/domaincommon.rng
@@ -2559,12 +2559,12 @@
            <ref name="UUID"/>
          </attribute>
          <attribute name='usage'>
-          <ref name='usageName'/>
+          <ref name='genericName'/>
          </attribute>
        </choice>
      </element>
    </define>
-
+
    <!--
         Optional hypervisor extensions in their own namespace:
           QEmu
@@ -2660,11 +2660,6 @@
        <param name="pattern">[A-Za-z0-9_\.\+\-]+</param>
      </data>
    </define>
-  <define name="genericName">
-    <data type="string">
-      <param name="pattern">[a-zA-Z0-9_\+\-]+</param>
-    </data>
-  </define>
    <define name="bridgeMode">
      <data type="string">
        <param name="pattern">(vepa|bridge|private|passthrough)</param>
@@ -2675,11 +2670,6 @@
        <param 
name="pattern">(([0-2]?[0-9]?[0-9]\.){3}[0-2]?[0-9]?[0-9])|(([0-9a-fA-F]+|:)+[0-9a-fA-F]+)|([a-zA-Z0-9_\.\+\-]*)</param>
      </data>
    </define>
-  <define name="usageName">
-    <data type="string">
-      <param name="pattern">[a-zA-Z0-9_\.\+\-]+</param>
-    </data>
-  </define>
    <define name="usbId">
      <data type="string">
        <param name="pattern">(0x)?[0-9a-fA-F]{1,4}</param>
diff --git i/docs/schemas/secret.rng w/docs/schemas/secret.rng
index 3abd3c7..e49bd5a 100644
--- i/docs/schemas/secret.rng
+++ w/docs/schemas/secret.rng
@@ -1,10 +1,11 @@
+<?xml version="1.0"?>
  <!-- A Relax NG schema for the libvirt secret properties XML format -->
  <grammar xmlns="http://relaxng.org/ns/structure/1.0">
    <start>
      <ref name='secret'/>
    </start>

-  <include href='domaincommon.rng'/>
+  <include href='basictypes.rng'/>

    <define name='secret'>
      <element name='secret'>
@@ -62,25 +63,8 @@
        <value>ceph</value>
      </attribute>
      <element name='name'>
-      <ref name='usageName'/>
+      <ref name='genericName'/>
      </element>
    </define>

-  <define name="UUID">
-    <choice>
-      <data type="string">
-        <param name="pattern">[a-fA-F0-9]{32}</param>
-      </data>
-      <data type="string">
-        <param 
name="pattern">[a-fA-F0-9]{8}\-([a-fA-F0-9]{4}\-){3}[a-fA-F0-9]{12}</param>
-      </data>
-    </choice>
-  </define>
-
-  <define name="absFilePath">
-    <data type="string">
-      <param name="pattern">/[a-zA-Z0-9_\.\+\-&amp;/%]+</param>
-    </data>
-  </define>
-
  </grammar>


-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
