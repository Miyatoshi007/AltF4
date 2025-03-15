package com.AltF4.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TrackUrl {
	public static String extractSrc(String iframeTag) {
		Pattern pattern = Pattern.compile("src=\"([^\"]*)\"");
		Matcher matcher = pattern.matcher(iframeTag);

		if (matcher.find()) {
			return matcher.group(1);
		}
		return null;
	}
}
