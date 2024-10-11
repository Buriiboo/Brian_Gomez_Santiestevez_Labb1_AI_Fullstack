import streamlit as st
from utils.query_database import QueryDatabase

class ContentKPI:
    def __init__(self) -> None:
        self._content = QueryDatabase("SELECT * FROM marts.content_view_time;").df

    def display_content(self):
        df = self._content
        st.markdown("## KPIer för videor")
        st.markdown("Nedan visas KPIer för totalt antal")

        kpis = {
            "videor": len(df),
            "visade timmar": df["Visningstid_timmar"].sum(),
            "prenumeranter": df["Prenumeranter"].sum(),
            "exponeringar": df["Exponeringar"].sum(),
        }

        for col, kpi in zip(st.columns(len(kpis)), kpis):
            with col: 
                st.metric(kpi, round(kpis[kpi]))
        st.dataframe(df)

# create more KPIs here
class DeviceKPI:
    def __init__(self) -> None:
        # Query for device types and their views
        self._device_views = QueryDatabase("""
            SELECT enhetstyp, COUNT(*) AS total_views
            FROM device_data
            GROUP BY enhetstyp
            ORDER BY total_views DESC;
        """).df

    def display_device_data(self):
        # Display the device views data
        st.markdown("## KPIer för Enhetstyper")
        st.markdown("Nedan visas antalet visningar för varje enhetstyp.")

        # Display the data frame
        st.dataframe(self._device_views)

        # Show bar chart for device views
        st.bar_chart(self._device_views.set_index('enhetstyp')['total_views'])
